use std::collections::{VecDeque, BinaryHeap, HashMap};
use std::cmp::Reverse;

fn bfs(
    start_r: i32,
    start_c: i32,
    m: i32,
    n: i32,
) -> HashMap<(i32, i32), usize> {
    let mut distances = HashMap::new();
    let mut q = VecDeque::new();

    q.push_back((start_r, start_c, 0));
    distances.insert((start_r, start_c), 0);

    let dr = [-1, 1, 0, 0];
    let dc = [0, 0, -1, 1];

    while let Some((r, c, dist)) = q.pop_front() {
        for i in 0..4 {
            let nr = r + dr[i];
            let nc = c + dc[i];

            if nr >= 0 && nr < m && nc >= 0 && nc < n {
                if !distances.contains_key(&(nr, nc)) {
                    distances.insert((nr, nc), dist + 1);
                    q.push_back((nr, nc, dist + 1));
                }
            }
        }
    }
    distances
}

impl Solution {
    pub fn minimum_moves(classroom: Vec<String>, k: i32, p: i32) -> i32 {
        let m = classroom.len() as i32;
        let n = classroom[0].len() as i32;

        let mut robot_start_pos = (0, 0);
        let mut dirty_cells = Vec::new();

        for r in 0..m {
            for c in 0..n {
                match classroom[r as usize].as_bytes()[c as usize] as char {
                    'R' => robot_start_pos = (r, c),
                    'C' => dirty_cells.push((r, c)),
                    _ => {}
                }
            }
        }

        let d_count = dirty_cells.len();
        if d_count == 0 {
            return 0;
        }

        // Map all relevant coordinates (robot start + dirty cells) to graph node indices
        // Node 0: robot_start_pos
        // Nodes 1 to d_count: dirty_cells[0] to dirty_cells[d_count-1]
        let mut all_nodes_coords = Vec::new();
        all_nodes_coords.push(robot_start_pos);
        all_nodes_coords.extend_from_slice(&dirty_cells);

        let num_graph_nodes = d_count + 1;
        let mut dist_matrix = vec![vec![usize::MAX; num_graph_nodes]; num_graph_nodes];

        // Precompute all-pairs shortest paths between robot start and all dirty cells, and between dirty cells
        for i in 0..num_graph_nodes {
            let (sr, sc) = all_nodes_coords[i];
            let distances_from_s = bfs(sr, sc, m, n);
            for j in 0..num_graph_nodes {
                let (tr, tc) = all_nodes_coords[j];
                if let Some(&dist) = distances_from_s.get(&(tr, tc)) {
                    dist_matrix[i][j] = dist;
                }
            }
        }

        // Dijkstra's algorithm
        // State: (cost, current_robot_node_idx, cleaned_mask, robots_deployed_count)
        // current_robot_node_idx: 0 for robot_start_pos, 1..d_count for dirty_cells
        // cleaned_mask: bitmask where the i-th bit is set if dirty_cells[i] has been cleaned
        //               (either by main robot or an additional robot)
        // robots_deployed_count: number of additional robots used so far
        let mut min_costs = vec![
            vec![vec![usize::MAX; k as usize + 1]; 1 << d_count];
            num_graph_nodes
        ];
        let mut pq = BinaryHeap::new();

        // Initial state: cost 0, at robot_start_pos (node 0), no cells cleaned, no robots deployed
        min_costs[0][0][0] = 0;
        pq.push(Reverse((0, 0, 0u16, 0u8)));

        let p_usize = p as usize;

        while let Some(Reverse((cost, u_idx, mask, k_used))) = pq.pop() {
            if cost > min_costs[u_idx][mask as usize][k_used as usize] {
                continue;
            }

            // Option 1: Move main robot to clean a dirty cell
            // Iterate through all dirty cells (which are graph nodes 1 to d_count)
            for v_idx in 1..num_graph_nodes { 
                let dirty_cell_bit = 1 << (v_idx - 1); // Bit corresponding to dirty_cells[v_idx-1]
                if (mask & dirty_cell_bit) == 0 { // If this dirty cell is not yet cleaned
                    let move_cost = dist_matrix[u_idx][v_idx];
                    if move_cost == usize::MAX { // If unreachable
                        continue;
                    }
                    let new_cost = cost + move_cost;
                    let new_mask = mask | dirty_cell_bit; // Mark this dirty cell as cleaned

                    if new_cost < min_costs[v_idx][new_mask as usize][k_used as usize] {
                        min_costs[v_idx][new_mask as usize][k_used as usize] = new_cost;
                        pq.push(Reverse((new_cost, v_idx, new_mask, k_used)));
                    }
                }
            }

            // Option 2: Deploy an additional robot to clean a dirty cell
            if k_used < k as u8 { // If we still have additional robots to deploy
                // Iterate through all dirty cells (which are graph nodes 1 to d_count)
                for v_idx in 1..num_graph_nodes { 
                    let dirty_cell_bit = 1 << (v_idx - 1); // Bit corresponding to dirty_cells[v_idx-1]
                    if (mask & dirty_cell_bit) == 0 { // If this dirty cell is not yet cleaned
                        let new_cost = cost + p_usize;
                        let new_mask = mask | dirty_cell_bit; // Mark this dirty cell as cleaned
                        let new_k_used = k_used + 1;

                        // The main robot's position (u_idx) does not change when deploying an additional robot
                        if new_cost < min_costs[u_idx][new_mask as usize][new_k_used as usize] {
                            min_costs[u_idx][new_mask as usize][new_k_used as usize] = new_cost;
                            pq.push(Reverse((new_cost, u_idx, new_mask, new_k_used)));
                        }
                    }
                }
            }
        }

        // Find the minimum cost among all states where all dirty cells are cleaned
        let final_mask = (1 << d_count) - 1; // Mask where all bits corresponding to dirty cells are set
        let mut min_total_cost = usize::MAX;

        for u_idx in 0..num_graph_nodes {
            for k_used in 0..=(k as usize) {
                min_total_cost = min_total_cost.min(min_costs[u_idx][final_mask][k_used]);
            }
        }

        min_total_cost as i32
    }
}
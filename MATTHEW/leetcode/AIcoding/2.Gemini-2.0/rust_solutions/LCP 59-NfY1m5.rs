impl Solution {
    pub fn min_cost_connect_points(points: Vec<Vec<i32>>) -> i32 {
        let n = points.len();
        let mut adj: Vec<Vec<(usize, i32)>> = vec![vec![]; n];

        for i in 0..n {
            for j in i + 1..n {
                let dist = (points[i][0] - points[j][0]).abs() + (points[i][1] - points[j][1]).abs();
                adj[i].push((j, dist));
                adj[j].push((i, dist));
            }
        }

        let mut visited = vec![false; n];
        let mut min_heap: std::collections::BinaryHeap<(i32, usize)> = std::collections::BinaryHeap::new();
        min_heap.push((0, 0));
        let mut mst_cost = 0;
        let mut edges_used = 0;

        while edges_used < n {
            let (cost, u) = min_heap.pop().unwrap();
            let cost = -cost;

            if visited[u] {
                continue;
            }

            visited[u] = true;
            mst_cost += cost;
            edges_used += 1;

            for &(v, weight) in &adj[u] {
                if !visited[v] {
                    min_heap.push((-weight, v));
                }
            }
        }

        mst_cost
    }
}
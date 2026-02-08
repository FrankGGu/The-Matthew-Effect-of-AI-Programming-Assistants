use std::collections::BinaryHeap;

pub fn second_min_time(n: i32, edges: Vec<Vec<i32>>, time: i32, change: i32) -> i64 {
    let mut graph = vec![vec![]; n as usize];
    for edge in edges {
        graph[edge[0] as usize].push(edge[1]);
        graph[edge[1] as usize].push(edge[0]);
    }

    let mut dist = vec![vec![i64::MAX; 2]; n as usize];
    dist[0][0] = 0;

    let mut heap = BinaryHeap::new();
    heap.push((0, 0, 0)); // (time, node, state)

    while let Some((curr_time, node, state)) = heap.pop() {
        let curr_time = -curr_time;

        if node == (n - 1) {
            if state == 1 {
                return curr_time;
            }
            continue;
        }

        for &neigh in &graph[node as usize] {
            let mut next_time = curr_time + time as i64;
            let mut wait_time = 0;
            if (next_time / change as i64) % 2 == 1 {
                wait_time = change as i64 - next_time % change as i64;
                next_time += wait_time;
            }

            if next_time < dist[neigh as usize][0] {
                dist[neigh as usize][0] = next_time;
                heap.push((-next_time, neigh, 0));
            } else if next_time < dist[neigh as usize][1] && next_time > dist[neigh as usize][0] {
                dist[neigh as usize][1] = next_time;
                heap.push((-next_time, neigh, 1));
            }
        }
    }

    -1
}
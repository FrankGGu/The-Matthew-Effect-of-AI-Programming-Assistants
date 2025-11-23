use std::collections::BinaryHeap;

pub fn min_cost_connect_points(points: Vec<Vec<i32>>) -> i32 {
    let n = points.len();
    let mut visited = vec![false; n];
    let mut min_heap = BinaryHeap::new();
    min_heap.push((0, 0));
    let mut total_cost = 0;
    let mut edges_used = 0;

    while edges_used < n {
        if let Some((cost, point)) = min_heap.pop() {
            let cost = -cost;
            if visited[point] {
                continue;
            }
            visited[point] = true;
            total_cost += cost;
            edges_used += 1;

            for next in 0..n {
                if !visited[next] {
                    let dist = (points[point][0] - points[next][0]).abs() + (points[point][1] - points[next][1]).abs();
                    min_heap.push((-dist, next));
                }
            }
        }
    }
    total_cost
}
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

        let mut min_cost = 0;
        let mut visited = vec![false; n];
        let mut pq: std::collections::BinaryHeap<(std::cmp::Reverse<i32>, usize)> = std::collections::BinaryHeap::new();
        pq.push((std::cmp::Reverse(0), 0));

        let mut count = 0;
        while count < n {
            let (std::cmp::Reverse(cost), u) = pq.pop().unwrap();

            if visited[u] {
                continue;
            }

            visited[u] = true;
            min_cost += cost;
            count += 1;

            for &(v, weight) in &adj[u] {
                if !visited[v] {
                    pq.push((std::cmp::Reverse(weight), v));
                }
            }
        }

        min_cost
    }
}
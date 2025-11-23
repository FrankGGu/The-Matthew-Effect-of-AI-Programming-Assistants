impl Solution {
    pub fn min_cost(max_time: i32, edges: Vec<Vec<i32>>, passing_fees: Vec<i32>) -> i32 {
        let n = passing_fees.len();
        let mut dist = vec![i32::MAX; n];
        let mut cost = vec![i32::MAX; n];

        dist[0] = 0;
        cost[0] = passing_fees[0];

        let mut pq = std::collections::BinaryHeap::new();
        pq.push((std::cmp::Reverse(cost[0]), 0, dist[0]));

        while let Some((std::cmp::Reverse(curr_cost), u, curr_dist)) = pq.pop() {
            if curr_cost > cost[u] {
                continue;
            }

            if curr_dist > dist[u] {
                continue;
            }

            for edge in &edges {
                let (v, time, fee) = if edge[0] == u as i32 {
                    (edge[1] as usize, edge[2], passing_fees[edge[1] as usize])
                } else if edge[1] == u as i32 {
                    (edge[0] as usize, edge[2], passing_fees[edge[0] as usize])
                } else {
                    continue;
                };

                if curr_dist + time <= max_time {
                    if curr_dist + time < dist[v] {
                        dist[v] = curr_dist + time;
                        cost[v] = curr_cost + fee;
                        pq.push((std::cmp::Reverse(cost[v]), v, dist[v]));
                    } else if curr_dist + time == dist[v] && curr_cost + fee < cost[v] {
                        cost[v] = curr_cost + fee;
                        pq.push((std::cmp::Reverse(cost[v]), v, dist[v]));
                    }
                }
            }
        }

        if cost[n - 1] == i32::MAX {
            -1
        } else {
            cost[n - 1]
        }
    }
}
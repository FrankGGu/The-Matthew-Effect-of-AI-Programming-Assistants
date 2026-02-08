use std::collections::VecDeque;

impl Solution {
    pub fn closest_meeting_node(edges: Vec<i32>, node1: i32, node2: i32) -> i32 {
        let n = edges.len();
        let mut dist1 = vec![i32::MAX; n];
        let mut dist2 = vec![i32::MAX; n];

        let mut q1 = VecDeque::new();
        let mut q2 = VecDeque::new();

        dist1[node1 as usize] = 0;
        dist2[node2 as usize] = 0;

        q1.push_back(node1);
        q2.push_back(node2);

        while !q1.is_empty() {
            let u = q1.pop_front().unwrap();
            if edges[u as usize] != -1 {
                let v = edges[u as usize];
                if dist1[v as usize] == i32::MAX {
                    dist1[v as usize] = dist1[u as usize] + 1;
                    q1.push_back(v);
                }
            }
        }

        while !q2.is_empty() {
            let u = q2.pop_front().unwrap();
            if edges[u as usize] != -1 {
                let v = edges[u as usize];
                if dist2[v as usize] == i32::MAX {
                    dist2[v as usize] = dist2[u as usize] + 1;
                    q2.push_back(v);
                }
            }
        }

        let mut min_dist = i32::MAX;
        let mut ans = -1;

        for i in 0..n {
            if dist1[i] != i32::MAX && dist2[i] != i32::MAX {
                let max_dist = std::cmp::max(dist1[i], dist2[i]);
                if max_dist < min_dist {
                    min_dist = max_dist;
                    ans = i as i32;
                }
            }
        }

        ans
    }
}
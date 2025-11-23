impl Solution {
    pub fn minimum_score(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        use std::collections::{HashSet, HashMap};
        let n = nums.len();
        let mut graph = vec![vec![]; n];
        for edge in edges.iter() {
            graph[(edge[0] - 1) as usize].push(edge[1] - 1);
            graph[(edge[1] - 1) as usize].push(edge[0] - 1);
        }

        let mut min_score = i32::MAX;

        for i in 0..n {
            for j in 0..n {
                if i != j {
                    let mut visited = vec![false; n];
                    let mut q = vec![i];
                    visited[i] = true;
                    let mut total = 0;

                    while let Some(node) = q.pop() {
                        total += nums[node];
                        for &neigh in &graph[node] {
                            if !visited[neigh] {
                                visited[neigh] = true;
                                q.push(neigh);
                            }
                        }
                    }

                    let score = total - nums[i] - nums[j];
                    min_score = min_score.min(score);
                }
            }
        }

        min_score
    }
}
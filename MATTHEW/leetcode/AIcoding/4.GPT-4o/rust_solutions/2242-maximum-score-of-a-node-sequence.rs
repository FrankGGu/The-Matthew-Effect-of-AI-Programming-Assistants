impl Solution {
    pub fn maximum_score(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        use std::collections::HashMap;
        let mut graph = vec![vec![]; nums.len()];
        for edge in edges.iter() {
            graph[edge[0] as usize].push(edge[1] as usize);
            graph[edge[1] as usize].push(edge[0] as usize);
        }

        let mut max_score = -1;
        for i in 0..nums.len() {
            let mut top_two = vec![];
            for &neighbor in graph[i].iter() {
                top_two.push(nums[neighbor]);
                if top_two.len() > 2 {
                    top_two.sort_unstable();
                    top_two.pop();
                }
            }
            if top_two.len() == 2 {
                max_score = max_score.max(nums[i] + top_two[0] + top_two[1]);
            }
        }
        max_score
    }
}
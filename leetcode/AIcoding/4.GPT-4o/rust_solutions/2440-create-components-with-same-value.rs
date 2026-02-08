use std::collections::HashMap;

pub struct Solution;

impl Solution {
    pub fn component_value(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> i32 {
        let total_sum: i32 = nums.iter().sum();
        let n = nums.len();
        let mut graph = vec![vec![]; n];
        for edge in edges {
            graph[edge[0] as usize].push(edge[1] as usize);
            graph[edge[1] as usize].push(edge[0] as usize);
        }

        let mut max_components = 1;
        for i in 1..=total_sum {
            if total_sum % i == 0 {
                let target = total_sum / i;
                if Self::can_form_components(0, -1, target, &nums, &graph) == i {
                    max_components = i;
                }
            }
        }
        max_components
    }

    fn can_form_components(node: usize, parent: isize, target: i32, nums: &[i32], graph: &[Vec<usize>]) -> i32 {
        let mut current_sum = nums[node];
        let mut components = 0;

        for &neighbor in &graph[node] {
            if neighbor as isize != parent {
                current_sum += Self::can_form_components(neighbor, node as isize, target, nums, graph);
            }
        }

        if current_sum == target {
            components += 1;
            current_sum = 0;
        }

        current_sum
    }
}
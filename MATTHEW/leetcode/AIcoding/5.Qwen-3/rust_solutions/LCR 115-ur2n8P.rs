impl Solution {

use std::collections::{HashMap, VecDeque};

impl Solution {
    pub fn can_reconstruct_sequence(nums: Vec<i32>, edges: Vec<Vec<i32>>) -> bool {
        let n = nums.len();
        let mut graph = HashMap::new();
        let mut in_degree = HashMap::new();

        for i in 0..n {
            graph.insert(nums[i], Vec::new());
            in_degree.insert(nums[i], 0);
        }

        for edge in edges {
            let u = edge[0];
            let v = edge[1];
            graph.get_mut(&u).unwrap().push(v);
            *in_degree.get_mut(&v).unwrap() += 1;
        }

        let mut queue = VecDeque::new();
        for &num in &nums {
            if *in_degree.get(&num).unwrap() == 0 {
                queue.push_back(num);
            }
        }

        let mut result = Vec::new();
        while let Some(node) = queue.pop_front() {
            result.push(node);
            for &neighbor in graph.get(&node).unwrap() {
                *in_degree.get_mut(&neighbor).unwrap() -= 1;
                if *in_degree.get(&neighbor).unwrap() == 0 {
                    queue.push_back(neighbor);
                }
            }
        }

        result == nums
    }
}
}
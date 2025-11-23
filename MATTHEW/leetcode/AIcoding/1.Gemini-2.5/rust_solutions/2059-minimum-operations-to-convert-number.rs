use std::collections::VecDeque;

impl Solution {
    pub fn minimum_operations(nums: Vec<i32>, start: i32, target: i32) -> i32 {
        if start == target {
            return 0;
        }

        let mut queue: VecDeque<(i32, i32)> = VecDeque::new();
        let mut visited = [false; 1001]; // For numbers in range [0, 1000]

        queue.push_back((start, 0));
        if start >= 0 && start <= 1000 {
            visited[start as usize] = true;
        }

        while let Some((current_num, steps)) = queue.pop_front() {
            for &num_op in nums.iter() {
                let next_states = [
                    current_num + num_op,
                    current_num - num_op,
                    current_num ^ num_op,
                ];

                for next_num in next_states.iter() {
                    if *next_num == target {
                        return steps + 1;
                    }

                    if *next_num >= 0 && *next_num <= 1000 {
                        let next_num_usize = *next_num as usize;
                        if !visited[next_num_usize] {
                            visited[next_num_usize] = true;
                            queue.push_back((*next_num, steps + 1));
                        }
                    }
                }
            }
        }

        -1
    }
}
use std::collections::VecDeque;

impl Solution {
    pub fn max_coins(bags: Vec<i32>, k: i32) -> i32 {
        let k = k as usize;
        let mut bags = bags;
        bags.sort_unstable();
        let mut dp = vec![0; bags.len() + 1];
        let mut queue = VecDeque::new();
        queue.push_back(0);

        for i in 0..bags.len() {
            if let Some(&front) = queue.front() {
                if front + k < i {
                    queue.pop_front();
                }
            }
            if let Some(&front) = queue.front() {
                dp[i + 1] = dp[front] + bags[front] * bags[i];
            }
            while let Some(&back) = queue.back() {
                if dp[back] + bags[back] * bags[i] >= dp[i] {
                    break;
                }
                queue.pop_back();
            }
            queue.push_back(i);
        }

        dp[bags.len()]
    }
}
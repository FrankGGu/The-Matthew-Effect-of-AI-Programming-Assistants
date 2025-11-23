impl Solution {

use std::collections::VecDeque;

impl Solution {
    pub fn new21_game(mut total: i32) -> i32 {
        if total == 0 {
            return 0;
        }
        let mut dp = vec![0; total as usize + 1];
        dp[0] = 1;
        let mut window_sum = 1;
        let mut queue = VecDeque::new();
        queue.push_back(0);

        for i in 1..=total {
            if i > 21 {
                let front = queue.pop_front().unwrap();
                window_sum -= dp[front];
            }
            dp[i as usize] = window_sum;
            window_sum += dp[i as usize];
            queue.push_back(i);
            if i + 21 <= total {
                window_sum -= dp[i as usize];
            }
        }

        dp[total as usize]
    }
}
}
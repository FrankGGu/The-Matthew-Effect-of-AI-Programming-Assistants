use std::cmp;

impl Solution {
    pub fn maximize_win(mut events: Vec<Vec<i32>>, k: i32) -> i32 {
        let n = events.len();
        if n == 0 {
            return 0;
        }

        events.sort_unstable_by_key(|e| e[0]);

        let mut left_max_rewards = vec![0i64; n];
        let mut current_window_sum: i64 = 0;
        let mut left_window_ptr = 0;
        let mut max_single_segment_reward_up_to_current_idx: i64 = 0;

        for right_window_ptr in 0..n {
            current_window_sum += events[right_window_ptr][1] as i64;
            while events[right_window_ptr][0] - events[left_window_ptr][0] > k {
                current_window_sum -= events[left_window_ptr][1] as i64;
                left_window_ptr += 1;
            }
            max_single_segment_reward_up_to_current_idx = cmp::max(max_single_segment_reward_up_to_current_idx, current_window_sum);
            left_max_rewards[right_window_ptr] = max_single_segment_reward_up_to_current_idx;
        }

        let mut right_max_rewards = vec![0i64; n];
        current_window_sum = 0;
        let mut right_window_ptr = n - 1;
        max_single_segment_reward_up_to_current_idx = 0;

        for left_window_ptr_rev in (0..n).rev() {
            current_window_sum += events[left_window_ptr_rev][1] as i64;
            while events[right_window_ptr][0] - events[left_window_ptr_rev][0] > k {
                current_window_sum -= events[right_window_ptr][1] as i64;
                right_window_ptr -= 1;
            }
            max_single_segment_reward_up_to_current_idx = cmp::max(max_single_segment_reward_up_to_current_idx, current_window_sum);
            right_max_rewards[left_window_ptr_rev] = max_single_segment_reward_up_to_current_idx;
        }

        let mut max_total_reward: i64 = 0;

        max_total_reward = left_max_rewards[n - 1]; 

        for i in 0..(n - 1) {
            max_total_reward = cmp::max(max_total_reward, left_max_rewards[i] + right_max_rewards[i + 1]);
        }

        max_total_reward as i32
    }
}
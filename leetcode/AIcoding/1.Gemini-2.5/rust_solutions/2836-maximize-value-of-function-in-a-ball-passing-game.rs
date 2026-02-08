impl Solution {
    pub fn get_max_function_value(receiver: Vec<i32>, values: Vec<i32>, k: i64) -> i64 {
        let n = receiver.len();
        let max_log = 60; 

        let mut dp_next = vec![vec![0; n]; max_log];
        let mut dp_sum = vec![vec![0i128; n]; max_log];

        for i in 0..n {
            dp_next[0][i] = receiver[i] as usize;
            dp_sum[0][i] = values[i] as i128;
        }

        for j in 1..max_log {
            for i in 0..n {
                let prev_next_player = dp_next[j - 1][i];
                dp_next[j][i] = dp_next[j - 1][prev_next_player];
                dp_sum[j][i] = dp_sum[j - 1][i] + dp_sum[j - 1][prev_next_player];
            }
        }

        let mut max_total_value: i128 = 0;

        for start_node in 0..n {
            let mut current_node = start_node;
            let mut current_total_value: i128 = 0;
            let mut remaining_k = k;

            for j in (0..max_log).rev() {
                if ((remaining_k >> j) & 1) == 1 {
                    current_total_value += dp_sum[j][current_node];
                    current_node = dp_next[j][current_node];
                }
            }
            current_total_value += values[current_node] as i128;

            if start_node == 0 || current_total_value > max_total_value {
                max_total_value = current_total_value;
            }
        }

        max_total_value as i64
    }
}
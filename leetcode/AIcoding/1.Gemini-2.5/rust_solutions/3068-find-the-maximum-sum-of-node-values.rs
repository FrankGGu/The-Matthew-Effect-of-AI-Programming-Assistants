impl Solution {
    pub fn max_sum_node_values(nums: Vec<i32>, k: i32, edges: Vec<Vec<i32>>) -> i64 {
        let mut current_max_sum: i64 = 0;
        let mut xor_count: i32 = 0;
        let mut min_pos_gain: i64 = std::i64::MAX;
        let mut max_neg_gain: i64 = std::i64::MIN;

        for &num in nums.iter() {
            let num_i64 = num as i64;

            let val_if_xor = (num as i32 ^ k) as i64;
            let gain = val_if_xor - num_i64;

            if gain > 0 {
                current_max_sum += val_if_xor;
                xor_count += 1;
                min_pos_gain = min_pos_gain.min(gain);
            } else {
                current_max_sum += num_i64;
                max_neg_gain = max_neg_gain.max(gain);
            }
        }

        if xor_count % 2 == 0 {
            return current_max_sum;
        } else {
            let option1_sum = current_max_sum - min_pos_gain;

            if max_neg_gain == std::i64::MIN {
                return option1_sum;
            } else {
                let option2_sum = current_max_sum + max_neg_gain;
                return option1_sum.max(option2_sum);
            }
        }
    }
}
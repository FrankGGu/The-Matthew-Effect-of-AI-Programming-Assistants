impl Solution {
    pub fn min_cost_to_equalize_array(nums: Vec<i32>, cost1: i32, cost2: i32) -> i32 {
        let mod_val = 1_000_000_007;
        let max_num = *nums.iter().max().unwrap();
        let total: i64 = nums.iter().map(|&x| (max_num - x) as i64).sum();
        if total == 0 {
            return 0;
        }
        let mut min_cost = i64::MAX;
        let target_max = max_num + 2;

        for target in max_num..=target_max {
            let mut diff_sum = 0;
            let mut max_diff = 0;
            for &num in &nums {
                let diff = target - num;
                diff_sum += diff as i64;
                max_diff = max_diff.max(diff as i64);
            }
            if diff_sum == 0 {
                min_cost = 0;
                break;
            }
            let cost = if 2 * cost2 <= cost1 {
                let pairs = (diff_sum - max_diff).min(max_diff);
                (pairs * cost2 as i64 + (max_diff - pairs) * cost1 as i64) % mod_val
            } else {
                (diff_sum * cost1 as i64) % mod_val
            };
            min_cost = min_cost.min(cost);
        }
        min_cost as i32
    }
}
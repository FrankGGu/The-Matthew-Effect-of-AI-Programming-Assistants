use std::collections::HashMap;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let mut sum_map: HashMap<i32, Vec<i32>> = HashMap::new();
        let mut max_sum = -1;

        for &num in &nums {
            let digit_sum = num.to_string().chars().map(|c| c.to_digit(10).unwrap() as i32).sum::<i32>();
            sum_map.entry(digit_sum).or_insert(Vec::new()).push(num);
        }

        for v in sum_map.values() {
            if v.len() > 1 {
                let mut sorted = v.clone();
                sorted.sort_unstable();
                max_sum = max_sum.max(sorted[sorted.len() - 1] + sorted[sorted.len() - 2]);
            }
        }

        max_sum
    }
}
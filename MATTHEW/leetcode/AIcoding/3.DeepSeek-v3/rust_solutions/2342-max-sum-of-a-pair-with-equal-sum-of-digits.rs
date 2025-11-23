use std::collections::HashMap;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let mut sum_map: HashMap<i32, Vec<i32>> = HashMap::new();

        for num in nums {
            let mut sum = 0;
            let mut n = num;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            sum_map.entry(sum).or_default().push(num);
        }

        let mut max_sum = -1;
        for (_, values) in sum_map {
            if values.len() >= 2 {
                let mut sorted = values;
                sorted.sort_unstable_by(|a, b| b.cmp(a));
                let current_sum = sorted[0] + sorted[1];
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }
        }

        max_sum
    }
}
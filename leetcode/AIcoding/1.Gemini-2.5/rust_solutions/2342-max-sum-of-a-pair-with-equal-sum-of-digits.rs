use std::collections::HashMap;

impl Solution {
    pub fn maximum_sum(nums: Vec<i32>) -> i32 {
        let mut digit_sum_map: HashMap<i32, Vec<i32>> = HashMap::new();

        for num in nums {
            let mut sum = 0;
            let mut n = num;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            digit_sum_map.entry(sum).or_insert_with(Vec::new).push(num);
        }

        let mut max_sum = -1;

        for (_digit_sum, mut numbers) in digit_sum_map {
            if numbers.len() >= 2 {
                numbers.sort_unstable_by(|a, b| b.cmp(a));
                let current_sum = numbers[0] + numbers[1];
                if current_sum > max_sum {
                    max_sum = current_sum;
                }
            }
        }

        max_sum
    }
}
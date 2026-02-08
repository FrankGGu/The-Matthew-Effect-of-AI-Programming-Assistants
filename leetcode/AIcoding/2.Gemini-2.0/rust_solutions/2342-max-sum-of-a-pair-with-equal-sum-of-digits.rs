use std::collections::HashMap;

impl Solution {
    pub fn max_sum(nums: Vec<i32>) -> i32 {
        let mut map: HashMap<i32, Vec<i32>> = HashMap::new();
        for &num in &nums {
            let sum_digits = Solution::sum_digits(num);
            map.entry(sum_digits).or_insert(Vec::new()).push(num);
        }

        let mut max_sum = -1;
        for (_, nums) in map.iter_mut() {
            if nums.len() >= 2 {
                nums.sort_by(|a, b| b.cmp(a));
                max_sum = max_sum.max(nums[0] + nums[1]);
            }
        }

        max_sum
    }

    fn sum_digits(mut num: i32) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += num % 10;
            num /= 10;
        }
        sum
    }
}
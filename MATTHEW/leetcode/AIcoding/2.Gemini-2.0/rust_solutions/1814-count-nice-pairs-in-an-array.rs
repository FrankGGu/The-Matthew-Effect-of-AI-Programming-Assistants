use std::collections::HashMap;

impl Solution {
    pub fn count_nice_pairs(nums: Vec<i32>) -> i32 {
        let mut count: HashMap<i32, i32> = HashMap::new();
        let mut result: i32 = 0;

        for &num in &nums {
            let rev_num = Solution::reverse(num);
            let diff = num - rev_num;

            if count.contains_key(&diff) {
                result += count[&diff];
            }

            *count.entry(diff).or_insert(0) += 1;
        }

        result
    }

    fn reverse(num: i32) -> i32 {
        let mut num_copy = num;
        let mut reversed_num: i32 = 0;

        while num_copy > 0 {
            let digit = num_copy % 10;
            reversed_num = reversed_num * 10 + digit;
            num_copy /= 10;
        }

        reversed_num
    }
}
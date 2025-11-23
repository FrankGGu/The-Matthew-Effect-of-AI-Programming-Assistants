use std::collections::HashMap;

impl Solution {
    pub fn count_nice_pairs(nums: Vec<i32>) -> i32 {
        let mut count = HashMap::new();
        let mut res = 0;
        let modulo = 1_000_000_007;

        for num in nums {
            let rev = num.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap_or(0);
            let key = num - rev;
            let &c = count.get(&key).unwrap_or(&0);
            res = (res + c) % modulo;
            count.insert(key, c + 1);
        }

        res
    }
}
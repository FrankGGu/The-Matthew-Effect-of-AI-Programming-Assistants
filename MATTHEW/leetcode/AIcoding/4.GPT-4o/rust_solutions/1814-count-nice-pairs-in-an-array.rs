impl Solution {
    pub fn count_nice_pairs(nums: Vec<i32>) -> i32 {
        use std::collections::HashMap;
        let mut count = 0;
        let mut map = HashMap::new();

        for &num in &nums {
            let rev = num.to_string().chars().rev().collect::<String>().parse::<i32>().unwrap();
            let key = num - rev;
            count += map.get(&key).unwrap_or(&0);
            *map.entry(key).or_insert(0) += 1;
        }

        (count % 1_000_000_007) as i32
    }
}
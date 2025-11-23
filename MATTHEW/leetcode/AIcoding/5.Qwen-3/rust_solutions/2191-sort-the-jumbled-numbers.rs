impl Solution {

use std::collections::HashMap;

struct Solution {}

impl Solution {
    pub fn sort_jumbled(mut nums: Vec<i32>) -> Vec<i32> {
        let mut mapping = HashMap::new();
        for (i, &num) in nums.iter().enumerate() {
            let key = Self::get_key(num);
            mapping.entry(key).or_insert_with(Vec::new).push(i);
        }

        let mut indexed_nums: Vec<(usize, i32)> = nums.into_iter().enumerate().collect();
        indexed_nums.sort_by(|a, b| {
            let a_key = Self::get_key(a.1);
            let b_key = Self::get_key(b.1);
            a_key.cmp(&b_key)
        });

        indexed_nums.into_iter().map(|x| x.1).collect()
    }

    fn get_key(num: i32) -> String {
        num.to_string()
    }
}
}
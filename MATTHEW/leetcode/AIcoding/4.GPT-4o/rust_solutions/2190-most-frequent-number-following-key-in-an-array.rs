impl Solution {
    pub fn most_frequent(nums: Vec<i32>, key: i32) -> i32 {
        let mut freq = std::collections::HashMap::new();
        for i in 0..nums.len() - 1 {
            if nums[i] == key {
                *freq.entry(nums[i + 1]).or_insert(0) += 1;
            }
        }
        *freq.iter().max_by_key(|&(_, count)| count).map(|(num, _)| num).unwrap()
    }
}
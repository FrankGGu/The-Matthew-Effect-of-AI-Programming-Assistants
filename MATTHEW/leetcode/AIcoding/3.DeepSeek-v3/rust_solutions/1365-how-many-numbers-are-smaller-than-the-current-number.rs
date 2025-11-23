impl Solution {
    pub fn smaller_numbers_than_current(nums: Vec<i32>) -> Vec<i32> {
        let mut sorted_nums = nums.clone();
        sorted_nums.sort_unstable();
        let mut count_map = std::collections::HashMap::new();
        for (i, &num) in sorted_nums.iter().enumerate() {
            count_map.entry(num).or_insert(i as i32);
        }
        nums.iter().map(|&x| count_map[&x]).collect()
    }
}
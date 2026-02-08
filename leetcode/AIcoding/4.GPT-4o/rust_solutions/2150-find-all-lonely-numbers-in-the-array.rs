impl Solution {
    pub fn find_lonely_numbers(nums: Vec<i32>) -> Vec<i32> {
        let mut count = std::collections::HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        nums.into_iter()
            .filter(|&num| count.get(&num) == Some(&1) && !count.contains_key(&(num - 1)) && !count.contains_key(&(num + 1)))
            .collect()
    }
}
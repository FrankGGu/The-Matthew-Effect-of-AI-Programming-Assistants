impl Solution {
    pub fn sum_of_unique(nums: Vec<i32>) -> i32 {
        let mut count = std::collections::HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        count.iter().filter_map(|(&num, &c)| if c == 1 { Some(num) } else { None }).sum()
    }
}
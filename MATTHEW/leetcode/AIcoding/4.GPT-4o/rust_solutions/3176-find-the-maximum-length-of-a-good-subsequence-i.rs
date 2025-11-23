impl Solution {
    pub fn maximum_length_of_good_subsequence(nums: Vec<i32>) -> i32 {
        let mut count = std::collections::HashSet::new();
        for &num in &nums {
            count.insert(num);
        }
        count.len() as i32
    }
}
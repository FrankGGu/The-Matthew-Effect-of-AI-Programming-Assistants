impl Solution {
    pub fn sum_counts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut total = 0;
        for i in 0..n {
            let mut distinct = std::collections::HashSet::new();
            for j in i..n {
                distinct.insert(nums[j]);
                total += (distinct.len() * distinct.len()) as i32;
            }
        }
        total
    }
}
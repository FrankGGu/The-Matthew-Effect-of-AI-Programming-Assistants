impl Solution {
    pub fn maximum_count(nums: Vec<i32>) -> i32 {
        let (mut positive_count, mut negative_count) = (0, 0);
        for &num in &nums {
            if num > 0 {
                positive_count += 1;
            } else if num < 0 {
                negative_count += 1;
            }
        }
        positive_count.max(negative_count)
    }
}
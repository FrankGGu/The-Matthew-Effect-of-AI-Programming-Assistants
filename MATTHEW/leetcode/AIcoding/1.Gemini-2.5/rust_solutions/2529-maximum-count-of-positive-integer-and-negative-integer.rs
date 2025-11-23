impl Solution {
    pub fn max_count(nums: Vec<i32>) -> i32 {
        let mut neg_count = 0;
        let mut pos_count = 0;

        for &num in nums.iter() {
            if num < 0 {
                neg_count += 1;
            } else if num > 0 {
                pos_count += 1;
            }
        }

        neg_count.max(pos_count)
    }
}
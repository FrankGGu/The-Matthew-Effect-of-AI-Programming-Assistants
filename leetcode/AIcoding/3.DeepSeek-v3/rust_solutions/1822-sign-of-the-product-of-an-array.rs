impl Solution {
    pub fn array_sign(nums: Vec<i32>) -> i32 {
        let mut negative_count = 0;
        for &num in nums.iter() {
            if num == 0 {
                return 0;
            } else if num < 0 {
                negative_count += 1;
            }
        }
        if negative_count % 2 == 0 {
            1
        } else {
            -1
        }
    }
}
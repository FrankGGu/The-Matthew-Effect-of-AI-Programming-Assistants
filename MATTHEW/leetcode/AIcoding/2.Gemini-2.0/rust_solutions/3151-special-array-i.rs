impl Solution {
    pub fn special_array(nums: Vec<i32>) -> i32 {
        for i in 0..=nums.len() as i32 {
            let mut count = 0;
            for &num in &nums {
                if num >= i {
                    count += 1;
                }
            }
            if count == i {
                return i;
            }
        }
        -1
    }
}
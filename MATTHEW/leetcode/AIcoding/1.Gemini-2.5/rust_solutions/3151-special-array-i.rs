impl Solution {
    pub fn special_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        for x in 0..=n {
            let mut count = 0;
            for &num in &nums {
                if num >= x as i32 {
                    count += 1;
                }
            }
            if count == x as i32 {
                return x as i32;
            }
        }
        -1
    }
}
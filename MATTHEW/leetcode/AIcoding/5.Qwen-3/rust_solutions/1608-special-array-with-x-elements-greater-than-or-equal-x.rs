struct Solution;

impl Solution {
    pub fn special_array(mut nums: Vec<i32>) -> i32 {
        nums.sort();
        let n = nums.len() as i32;
        for i in 0..n {
            let x = n - i;
            if nums[i] >= x {
                return x;
            }
        }
        0
    }
}
impl Solution {
    pub fn special_array(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        for x in 0..=n {
            if nums.iter().filter(|&&num| num >= x).count() == x {
                return x;
            }
        }
        -1
    }
}
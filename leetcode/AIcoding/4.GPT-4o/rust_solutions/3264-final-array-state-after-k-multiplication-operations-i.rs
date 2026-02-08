impl Solution {
    pub fn final_array(nums: Vec<i32>, k: i32) -> Vec<i32> {
        let mut result = nums;
        let n = result.len();
        for i in 0..n {
            result[i] *= 2_i32.pow(k as u32);
        }
        result
    }
}
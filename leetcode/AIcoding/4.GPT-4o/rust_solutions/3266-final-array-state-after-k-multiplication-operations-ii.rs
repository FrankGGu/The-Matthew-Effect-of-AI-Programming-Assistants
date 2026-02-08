impl Solution {
    pub fn final_array(k: i32, nums: Vec<i32>) -> Vec<i32> {
        let mut result = nums.clone();
        let mut factor = 1;

        for _ in 0..k {
            factor *= 2;
        }

        for i in 0..result.len() {
            result[i] *= factor;
        }

        result
    }
}
impl Solution {
    pub fn get_xor_sum(arr1: Vec<i32>, arr2: Vec<i32>) -> i32 {
        let mut xor1 = 0;
        for &num in &arr1 {
            xor1 ^= num;
        }
        let mut xor2 = 0;
        for &num in &arr2 {
            xor2 ^= num;
        }
        xor1 & xor2
    }
}
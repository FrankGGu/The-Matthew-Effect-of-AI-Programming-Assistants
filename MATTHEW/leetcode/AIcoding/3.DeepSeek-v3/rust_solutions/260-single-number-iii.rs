impl Solution {
    pub fn single_number(nums: Vec<i32>) -> Vec<i32> {
        let xor_all = nums.iter().fold(0, |acc, &x| acc ^ x);
        let mask = xor_all & -xor_all;
        let mut a = 0;
        let mut b = 0;
        for &num in &nums {
            if num & mask != 0 {
                a ^= num;
            } else {
                b ^= num;
            }
        }
        vec![a, b]
    }
}
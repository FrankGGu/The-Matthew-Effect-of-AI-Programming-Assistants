impl Solution {
    pub fn single_number(nums: Vec<i32>) -> Vec<i32> {
        let mut count = vec![0; 32];
        for num in nums {
            for i in 0..32 {
                count[i] += (num >> i) & 1;
            }
        }
        let mut result = 0;
        for i in 0..32 {
            if count[i] % 3 != 0 {
                result |= 1 << i;
            }
        }
        if count[31] % 3 != 0 {
            result -= 1 << 32;
        }
        vec![result]
    }
}
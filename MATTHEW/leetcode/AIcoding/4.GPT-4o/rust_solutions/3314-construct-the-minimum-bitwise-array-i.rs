impl Solution {
    pub fn minimum_bitwise_array(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut result = vec![0; n];
        let mut count = vec![0; 32];

        for &num in &nums {
            for i in 0..32 {
                if num & (1 << i) != 0 {
                    count[i] += 1;
                }
            }
        }

        for i in 0..n {
            for j in 0..32 {
                if count[j] == 1 {
                    result[i] |= (1 << j);
                }
            }
        }

        result
    }
}
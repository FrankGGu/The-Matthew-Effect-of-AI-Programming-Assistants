impl Solution {
    pub fn get_maximum_xor(nums: Vec<i32>, maximum_bit: i32) -> Vec<i32> {
        let mut xor_sum = 0;
        let max_num = (1 << maximum_bit) - 1;
        let mut res = Vec::with_capacity(nums.len());

        for &num in &nums {
            xor_sum ^= num;
            res.push(xor_sum ^ max_num);
        }

        res.reverse();
        res
    }
}
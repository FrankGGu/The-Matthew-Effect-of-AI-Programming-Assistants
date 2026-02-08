impl Solution {
    pub fn single_number(nums: Vec<i32>) -> Vec<i32> {
        let mut xor = 0;
        for num in nums.iter() {
            xor ^= num;
        }

        let rightmost_set_bit = xor & -xor;

        let mut num1 = 0;
        let mut num2 = 0;

        for num in nums.iter() {
            if num & rightmost_set_bit == 0 {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }

        vec![num1, num2]
    }
}
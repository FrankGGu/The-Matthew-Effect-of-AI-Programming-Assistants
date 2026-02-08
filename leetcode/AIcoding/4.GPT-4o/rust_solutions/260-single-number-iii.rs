impl Solution {
    pub fn single_number(nums: Vec<i32>) -> Vec<i32> {
        let mut xor = 0;
        for num in &nums {
            xor ^= num;
        }

        let mut mask = 1;
        while (xor & mask) == 0 {
            mask <<= 1;
        }

        let mut num1 = 0;
        let mut num2 = 0;

        for num in &nums {
            if (num & mask) == 0 {
                num1 ^= num;
            } else {
                num2 ^= num;
            }
        }

        vec![num1, num2]
    }
}
struct Solution;

impl Solution {
    pub fn reverse_number(mut num: i32) -> i32 {
        if num == 0 {
            return 0;
        }
        let mut reversed = 0;
        while num != 0 {
            reversed = reversed * 10 + num % 10;
            num /= 10;
        }
        reversed
    }

    pub fn is_number_after_double_reversal(num: i32) -> bool {
        let reversed1 = Solution::reverse_number(num);
        let reversed2 = Solution::reverse_number(reversed1);
        reversed2 == num
    }
}
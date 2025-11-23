impl Solution {
    pub fn sum_of_number_and_reverse(num: i32) -> bool {
        for i in 0..=num {
            let reversed = Solution::reverse(i);
            if i + reversed == num {
                return true;
            }
        }
        false
    }

    fn reverse(mut n: i32) -> i32 {
        let mut reversed = 0;
        while n > 0 {
            let digit = n % 10;
            reversed = reversed * 10 + digit;
            n /= 10;
        }
        reversed
    }
}
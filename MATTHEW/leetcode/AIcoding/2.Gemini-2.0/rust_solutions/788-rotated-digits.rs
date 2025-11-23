impl Solution {
    pub fn rotated_digits(n: i32) -> i32 {
        let mut count = 0;
        for i in 1..=n {
            if Solution::is_good_number(i) {
                count += 1;
            }
        }
        count
    }

    fn is_good_number(n: i32) -> bool {
        let mut changed = false;
        let mut num = n;
        while num > 0 {
            let digit = num % 10;
            if digit == 3 || digit == 4 || digit == 7 {
                return false;
            }
            if digit == 2 || digit == 5 || digit == 6 || digit == 9 {
                changed = true;
            }
            num /= 10;
        }
        changed
    }
}
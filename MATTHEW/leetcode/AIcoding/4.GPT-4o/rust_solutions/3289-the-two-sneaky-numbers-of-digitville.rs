impl Solution {
    pub fn find_two_sneaky_numbers(n: i32) -> Vec<i32> {
        let mut result = vec![];
        let mut count = 0;
        let mut i = 1;

        while count < 2 {
            if !Self::is_sneaky(i) {
                result.push(i);
                count += 1;
            }
            i += 1;
        }

        result
    }

    fn is_sneaky(num: i32) -> bool {
        let mut digits = vec![];
        let mut n = num;

        while n > 0 {
            digits.push(n % 10);
            n /= 10;
        }

        digits.reverse();

        for i in 1..digits.len() {
            if digits[i] <= digits[i - 1] {
                return true;
            }
        }

        false
    }
}
impl Solution {
    fn reverse(mut n: i32) -> i32 {
        let mut reversed_n = 0;
        while n > 0 {
            let digit = n % 10;
            reversed_n = reversed_n * 10 + digit;
            n /= 10;
        }
        reversed_n
    }

    pub fn sum_of_number_and_its_reverse(num: i32) -> bool {
        for x in 0..=num {
            if x + Self::reverse(x) == num {
                return true;
            }
        }
        false
    }
}
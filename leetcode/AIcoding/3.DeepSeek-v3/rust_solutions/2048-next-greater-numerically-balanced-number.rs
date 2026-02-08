impl Solution {
    pub fn next_beautiful_number(n: i32) -> i32 {
        let mut num = n + 1;
        loop {
            if Self::is_balanced(num) {
                return num;
            }
            num += 1;
        }
    }

    fn is_balanced(mut num: i32) -> bool {
        let mut count = [0; 10];
        while num > 0 {
            let digit = (num % 10) as usize;
            if digit == 0 {
                return false;
            }
            count[digit] += 1;
            num /= 10;
        }
        for d in 1..=9 {
            if count[d] > 0 && count[d] != d {
                return false;
            }
        }
        true
    }
}
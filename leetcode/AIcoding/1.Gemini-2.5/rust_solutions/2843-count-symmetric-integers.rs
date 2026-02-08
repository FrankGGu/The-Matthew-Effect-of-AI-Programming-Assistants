impl Solution {
    pub fn count_symmetric_integers(low: i32, high: i32) -> i32 {
        let mut count = 0;
        for num in low..=high {
            let s = num.to_string();
            let len = s.len();

            if len % 2 == 0 {
                let mid = len / 2;
                let mut sum_first_half = 0;
                let mut sum_second_half = 0;

                for (i, c) in s.chars().enumerate() {
                    let digit = c.to_digit(10).unwrap();
                    if i < mid {
                        sum_first_half += digit;
                    } else {
                        sum_second_half += digit;
                    }
                }

                if sum_first_half == sum_second_half {
                    count += 1;
                }
            }
        }
        count
    }
}
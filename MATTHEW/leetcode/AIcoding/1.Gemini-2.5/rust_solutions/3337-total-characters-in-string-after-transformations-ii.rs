impl Solution {
    pub fn get_lucky(s: String, k: i32) -> i32 {
        fn sum_digits(mut n: i32) -> i32 {
            let mut sum = 0;
            while n > 0 {
                sum += n % 10;
                n /= 10;
            }
            sum
        }

        let mut first_transformation_sum: i32 = 0;
        for c in s.chars() {
            let val = (c as u8 - b'a' + 1) as i32;
            if val < 10 {
                first_transformation_sum += val;
            } else {
                first_transformation_sum += val / 10;
                first_transformation_sum += val % 10;
            }
        }

        let mut current_sum = first_transformation_sum;

        for _ in 1..k {
            if current_sum < 10 {
                break;
            }
            current_sum = sum_digits(current_sum);
        }

        current_sum
    }
}
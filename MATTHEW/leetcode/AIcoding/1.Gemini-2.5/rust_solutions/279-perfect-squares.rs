impl Solution {
    pub fn num_squares(n: i32) -> i32 {
        fn is_perfect_square(num: i32) -> bool {
            if num < 0 {
                return false;
            }
            let sqrt_num = (num as f64).sqrt() as i32;
            sqrt_num * sqrt_num == num
        }

        if is_perfect_square(n) {
            return 1;
        }

        let mut temp_n = n;
        while temp_n % 4 == 0 {
            temp_n /= 4;
        }
        if temp_n % 8 == 7 {
            return 4;
        }

        let sqrt_n = (n as f64).sqrt() as i32;
        for i in 1..=sqrt_n {
            if is_perfect_square(n - i * i) {
                return 2;
            }
        }

        3
    }
}
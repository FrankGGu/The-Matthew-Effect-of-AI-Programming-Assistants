impl Solution {
    pub fn make_integer_beautiful(n: i64, target: i32) -> i64 {
        let mut x = 0;
        let mut m = n;
        while Self::digit_sum(m) > target {
            let mut step = 1;
            let mut next_m = m;
            while next_m % 10 == 0 {
                next_m /= 10;
                step *= 10;
            }
            step *= 10 - (next_m % 10);
            m += step;
            x += step;
        }
        x
    }

    fn digit_sum(mut num: i64) -> i32 {
        let mut sum = 0;
        while num > 0 {
            sum += (num % 10) as i32;
            num /= 10;
        }
        sum
    }
}
impl Solution {
    pub fn make_integer_beautiful(n: i64, target: i32) -> i64 {
        let mut num = n;
        let mut sum = 0;
        let mut temp = n;
        while temp > 0 {
            sum += (temp % 10) as i32;
            temp /= 10;
        }

        if sum <= target {
            return 0;
        }

        let mut power_of_ten = 1;
        while sum > target {
            let digit = num % 10;
            let addition = (10 - digit) % 10;
            num += addition * power_of_ten;
            sum -= digit as i32;
            sum += if addition == 0 { 0 } else { 1 };
            power_of_ten *= 10;
        }

        num - n
    }
}
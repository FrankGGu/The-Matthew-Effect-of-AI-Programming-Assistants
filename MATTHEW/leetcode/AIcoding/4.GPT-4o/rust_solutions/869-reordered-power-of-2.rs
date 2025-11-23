impl Solution {
    pub fn reordered_power_of2(n: i32) -> bool {
        let count_digits = |mut x: i32| {
            let mut count = [0; 10];
            while x > 0 {
                count[(x % 10) as usize] += 1;
                x /= 10;
            }
            count
        };

        let n_count = count_digits(n);
        let mut power_of_2 = 1;
        while power_of_2 <= 1_000_000_000 {
            if n_count == count_digits(power_of_2) {
                return true;
            }
            power_of_2 *= 2;
        }
        false
    }
}
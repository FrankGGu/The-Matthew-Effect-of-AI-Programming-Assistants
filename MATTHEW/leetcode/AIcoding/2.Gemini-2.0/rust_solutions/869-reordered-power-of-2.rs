impl Solution {
    pub fn reordered_power_of2(n: i32) -> bool {
        let mut digits = Vec::new();
        let mut num = n;
        while num > 0 {
            digits.push(num % 10);
            num /= 10;
        }
        digits.sort();

        let mut powers = Vec::new();
        let mut power: i64 = 1;
        while power <= 1_000_000_000 {
            powers.push(power);
            power *= 2;
        }

        for p in powers {
            let mut power_digits = Vec::new();
            let mut temp = p;
            while temp > 0 {
                power_digits.push((temp % 10) as i32);
                temp /= 10;
            }
            power_digits.sort();

            if digits.len() == power_digits.len() {
                if digits == power_digits {
                    return true;
                }
            }
        }

        false
    }
}
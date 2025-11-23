impl Solution {
    pub fn get_lucky(s: String, k: i32) -> i32 {
        let mut digits: Vec<i32> = s.chars()
            .map(|c| (c as u8 - b'a' + 1) as i32)
            .collect();

        let mut sum = 0;
        for &num in &digits {
            sum += if num < 10 { num } else { num / 10 + num % 10 };
        }

        for _ in 1..k {
            let mut new_sum = 0;
            let mut n = sum;
            while n > 0 {
                new_sum += n % 10;
                n /= 10;
            }
            sum = new_sum;
        }

        sum
    }
}
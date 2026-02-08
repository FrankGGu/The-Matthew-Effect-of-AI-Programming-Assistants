impl Solution {
    pub fn get_lucky(s: String, k: i32) -> i32 {
        let mut num_str = String::new();
        for c in s.chars() {
            let position = (c as u8 - b'a' + 1).to_string();
            num_str.push_str(&position);
        }

        let mut current_sum: i32 = num_str
            .chars()
            .map(|c| c.to_digit(10).unwrap() as i32)
            .sum();

        for _ in 1..k {
            let mut temp_sum = 0;
            let mut n = current_sum;
            while n > 0 {
                temp_sum += n % 10;
                n /= 10;
            }
            current_sum = temp_sum;
        }

        current_sum
    }
}
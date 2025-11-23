impl Solution {
    pub fn get_sum_of_string(s: String, n: i32) -> i32 {
        let mut sum = 0;
        let mut current = s.clone();

        for _ in 0..n {
            current = current.chars().map(|c| ((c as u8 - b'a' + 1) % 10) as char).collect();
        }

        for c in current.chars() {
            sum += c as i32 - '0' as i32;
        }

        sum
    }
}
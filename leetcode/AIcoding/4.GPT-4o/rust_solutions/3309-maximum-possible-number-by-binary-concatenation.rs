impl Solution {
    pub fn maximum_possible_number(num: String, change: Vec<i32>) -> String {
        let mut num_chars: Vec<char> = num.chars().collect();
        let mut changed = false;

        for i in 0..num_chars.len() {
            let digit = num_chars[i].to_digit(10).unwrap() as i32;
            if digit < change[digit as usize] {
                num_chars[i] = std::char::from_digit(change[digit as usize] as u32, 10).unwrap();
                changed = true;
            } else if changed {
                break;
            }
        }

        num_chars.iter().collect()
    }
}
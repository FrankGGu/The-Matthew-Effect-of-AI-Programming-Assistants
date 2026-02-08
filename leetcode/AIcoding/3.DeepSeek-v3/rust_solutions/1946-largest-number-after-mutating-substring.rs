impl Solution {
    pub fn maximum_number(num: String, change: Vec<i32>) -> String {
        let mut num_chars: Vec<char> = num.chars().collect();
        let mut mutated = false;
        for i in 0..num_chars.len() {
            let digit = num_chars[i].to_digit(10).unwrap() as usize;
            if change[digit] > digit as i32 {
                num_chars[i] = std::char::from_digit(change[digit] as u32, 10).unwrap();
                mutated = true;
            } else if change[digit] < digit as i32 && mutated {
                break;
            }
        }
        num_chars.into_iter().collect()
    }
}
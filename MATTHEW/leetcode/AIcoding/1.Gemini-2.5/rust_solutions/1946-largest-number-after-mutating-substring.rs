impl Solution {
    pub fn largest_number_after_mutating_substring(num: String, change: Vec<i32>) -> String {
        let mut chars: Vec<char> = num.chars().collect();
        let n = chars.len();
        let mut start_mutation_idx: Option<usize> = None;

        for i in 0..n {
            let digit = (chars[i] as u8 - b'0') as usize;
            if change[digit] > digit as i32 {
                start_mutation_idx = Some(i);
                break;
            }
        }

        if let Some(start_idx) = start_mutation_idx {
            for i in start_idx..n {
                let digit = (chars[i] as u8 - b'0') as usize;
                if change[digit] >= digit as i32 {
                    chars[i] = (change[digit] as u8 + b'0') as char;
                } else {
                    break;
                }
            }
        }

        chars.into_iter().collect()
    }
}
impl Solution {
    pub fn maximum_69_number (num: i32) -> i32 {
        let mut s = num.to_string();
        let mut chars: Vec<char> = s.chars().collect();

        for i in 0..chars.len() {
            if chars[i] == '6' {
                chars[i] = '9';
                break;
            }
        }

        let modified_s: String = chars.into_iter().collect();
        modified_s.parse::<i32>().unwrap()
    }
}
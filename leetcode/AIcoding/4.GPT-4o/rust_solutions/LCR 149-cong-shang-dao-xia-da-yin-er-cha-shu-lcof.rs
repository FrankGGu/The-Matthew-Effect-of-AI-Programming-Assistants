impl Solution {
    pub fn count_lights(s: String) -> Vec<i32> {
        let mut result = vec![0; 3];
        let chars: Vec<char> = s.chars().collect();
        let n = chars.len();

        for i in 0..n {
            if chars[i] == 'R' {
                result[0] += 1;
            } else if chars[i] == 'G' {
                result[1] += 1;
            } else if chars[i] == 'B' {
                result[2] += 1;
            }
        }

        result
    }
}
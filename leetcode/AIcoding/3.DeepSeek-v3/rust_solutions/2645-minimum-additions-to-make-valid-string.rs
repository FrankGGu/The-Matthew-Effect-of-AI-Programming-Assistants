impl Solution {
    pub fn add_minimum(word: String) -> i32 {
        let mut res = 0;
        let mut expected = 'a';
        let chars: Vec<char> = word.chars().collect();
        let mut i = 0;
        while i < chars.len() {
            if chars[i] == expected {
                i += 1;
            } else {
                res += 1;
            }
            expected = match expected {
                'a' => 'b',
                'b' => 'c',
                _ => 'a',
            };
        }
        if expected != 'a' {
            res += match expected {
                'b' => 2,
                'c' => 1,
                _ => 0,
            };
        }
        res
    }
}
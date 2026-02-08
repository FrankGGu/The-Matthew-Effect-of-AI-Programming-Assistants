impl Solution {
    pub fn compressed_string(word: String) -> String {
        let mut res = String::new();
        let chars: Vec<char> = word.chars().collect();
        let n = chars.len();
        let mut i = 0;

        while i < n {
            let current = chars[i];
            let mut count = 1;
            i += 1;

            while i < n && chars[i] == current && count < 9 {
                count += 1;
                i += 1;
            }

            res.push_str(&count.to_string());
            res.push(current);
        }

        res
    }
}
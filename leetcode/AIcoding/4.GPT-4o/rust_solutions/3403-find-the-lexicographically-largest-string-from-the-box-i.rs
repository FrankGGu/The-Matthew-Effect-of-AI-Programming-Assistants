impl Solution {
    pub fn find_lex_largest_string(s: String, r: Vec<i32>) -> String {
        let mut chars: Vec<char> = s.chars().collect();
        let n = chars.len();
        let mut visited = vec![false; n];
        let mut result = String::new();

        for i in (0..n).rev() {
            if visited[i] {
                continue;
            }
            let mut j = i;
            let mut temp = vec![];
            while j < n && !visited[j] {
                visited[j] = true;
                temp.push(chars[j]);
                j += r[j] as usize;
            }
            temp.sort_unstable_by(|a, b| b.cmp(a));
            result.push_str(&temp.iter().collect::<String>());
        }

        result
    }
}
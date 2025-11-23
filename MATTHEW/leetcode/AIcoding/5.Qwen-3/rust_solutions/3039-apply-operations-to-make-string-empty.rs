impl Solution {
    pub fn apply_operations(s: String) -> String {
        let mut s = s.chars().collect::<Vec<char>>();
        let n = s.len();

        for i in 0..n {
            if s[i] == '#' {
                continue;
            }
            let mut j = i + 1;
            while j < n && s[j] == '#' {
                j += 1;
            }
            if j < n {
                s[i] = s[j];
                s[j] = '#';
            }
        }

        s.into_iter().filter(|&c| c != '#').collect()
    }
}
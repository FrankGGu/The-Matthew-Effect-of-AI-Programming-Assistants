impl Solution {
    pub fn count_good_substrings(s: String) -> i32 {
        let n = s.len();
        if n < 3 {
            return 0;
        }

        let chars: Vec<char> = s.chars().collect();
        let mut count = 0;

        for i in 0..=n - 3 {
            let c1 = chars[i];
            let c2 = chars[i + 1];
            let c3 = chars[i + 2];

            if c1 != c2 && c1 != c3 && c2 != c3 {
                count += 1;
            }
        }

        count
    }
}
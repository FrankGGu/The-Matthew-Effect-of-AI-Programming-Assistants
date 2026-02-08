impl Solution {
    pub fn beautiful_substrings(s: String, k: i32) -> i64 {
        let n = s.len();
        let s: Vec<char> = s.chars().collect();
        let mut count = 0;
        for i in 0..n {
            for j in i..n {
                let sub = &s[i..=j];
                let mut vowels = 0;
                let mut consonants = 0;
                for &c in sub {
                    if c == 'a' || c == 'e' || c == 'i' || c == 'o' || c == 'u' {
                        vowels += 1;
                    } else {
                        consonants += 1;
                    }
                }
                if vowels == consonants && vowels * consonants % k == 0 {
                    count += 1;
                }
            }
        }
        count
    }
}
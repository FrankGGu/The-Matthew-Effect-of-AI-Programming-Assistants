impl Solution {
    pub fn beautiful_substrings(s: String, k: i32) -> i32 {
        let s_bytes = s.as_bytes();
        let n = s_bytes.len();
        let mut count = 0;

        for i in 0..n {
            for j in i..n {
                let sub = &s_bytes[i..=j];
                let mut vowels = 0;
                let mut consonants = 0;

                for &c in sub {
                    if c == b'a' || c == b'e' || c == b'i' || c == b'o' || c == b'u' {
                        vowels += 1;
                    } else {
                        consonants += 1;
                    }
                }

                if vowels == consonants && (vowels * consonants) as i32 % k == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}
impl Solution {
    pub fn count_substrings(s: String, k: i32) -> i32 {
        let s = s.as_bytes();
        let n = s.len();
        let mut res = 0;
        for i in 0..n {
            let mut vowels = 0;
            let mut consonants = 0;
            for j in i..n {
                match s[j] {
                    b'a' | b'e' | b'i' | b'o' | b'u' => vowels += 1,
                    _ => consonants += 1,
                }
                if vowels >= 1 && consonants == k {
                    res += 1;
                }
            }
        }
        res
    }
}
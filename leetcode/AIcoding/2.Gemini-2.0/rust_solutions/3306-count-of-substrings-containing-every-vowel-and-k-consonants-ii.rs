impl Solution {
    pub fn count_vowel_strings(word: String, k: i32) -> i64 {
        let s = word.as_bytes();
        let n = s.len();
        let mut ans = 0;
        for i in 0..n {
            let mut vowel = [false; 5];
            let mut consonant = 0;
            for j in i..n {
                match s[j] as char {
                    'a' => vowel[0] = true,
                    'e' => vowel[1] = true,
                    'i' => vowel[2] = true,
                    'o' => vowel[3] = true,
                    'u' => vowel[4] = true,
                    _ => consonant += 1,
                }
                if vowel.iter().all(|&x| x) && consonant >= k {
                    ans += (n - j) as i64;
                    break;
                }
            }
        }
        ans
    }
}
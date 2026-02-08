impl Solution {
    pub fn beautiful_substrings(s: String, k: i32) -> i32 {
        let s = s.chars().collect::<Vec<_>>();
        let n = s.len();
        let mut count = 0;

        for i in 0..n {
            let mut vowels = 0;
            let mut consonants = 0;
            for j in i..n {
                match s[j] {
                    'a' | 'e' | 'i' | 'o' | 'u' => vowels += 1,
                    _ => consonants += 1,
                }
                if vowels == consonants && (vowels * consonants) % k == 0 {
                    count += 1;
                }
            }
        }

        count
    }
}
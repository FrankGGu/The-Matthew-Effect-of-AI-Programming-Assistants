pub fn count_vowel_substrings(s: String, k: usize) -> i32 {
    let s = s.as_bytes();
    let n = s.len();
    let vowels = b"aeiou";
    let mut count = 0;

    for i in 0..n {
        let mut vowel_count = [0; 5];
        let mut consonant_count = 0;
        let mut total_vowels = 0;

        for j in i..n {
            if vowels.contains(&s[j]) {
                vowel_count[(s[j] - b'a') as usize] += 1;
                total_vowels += 1;
            } else {
                consonant_count += 1;
            }

            if total_vowels == 5 && consonant_count == k {
                count += 1;
            } else if total_vowels > 5 || consonant_count > k {
                break;
            }
        }
    }

    count
}
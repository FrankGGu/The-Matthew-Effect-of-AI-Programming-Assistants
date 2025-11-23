impl Solution {
    pub fn count_vowel_strings_in_ranges(words: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        #[inline(always)]
        fn is_vowel(c: char) -> bool {
            matches!(c, 'a' | 'e' | 'i' | 'o' | 'u')
        }

        let n = words.len();
        let mut prefix_sum = vec![0; n + 1];

        for i in 0..n {
            let word = &words[i];
            let first_char = word.chars().next().unwrap();
            let last_char = word.chars().last().unwrap();

            let is_vowel_str = is_vowel(first_char) && is_vowel(last_char);

            prefix_sum[i + 1] = prefix_sum[i] + (if is_vowel_str { 1 } else { 0 });
        }

        let mut results = Vec::with_capacity(queries.len());
        for query in queries {
            let start = query[0] as usize;
            let end = query[1] as usize;
            results.push(prefix_sum[end + 1] - prefix_sum[start]);
        }

        results
    }
}
impl Solution {
    pub fn vowel_strings(words: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let vowels = ['a', 'e', 'i', 'o', 'u'];
        let n = words.len();
        let mut prefix_sums = vec![0; n + 1];

        for i in 0..n {
            let word = &words[i];
            let first_char = word.chars().next().unwrap();
            let last_char = word.chars().last().unwrap();

            if vowels.contains(&first_char) && vowels.contains(&last_char) {
                prefix_sums[i + 1] = prefix_sums[i] + 1;
            } else {
                prefix_sums[i + 1] = prefix_sums[i];
            }
        }

        let mut result = Vec::new();
        for query in &queries {
            let start = query[0] as usize;
            let end = query[1] as usize;
            result.push(prefix_sums[end + 1] - prefix_sums[start]);
        }

        result
    }
}
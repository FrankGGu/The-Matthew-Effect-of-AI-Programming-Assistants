impl Solution {
    pub fn max_palindromes_after_operations(words: Vec<String>, queries: Vec<Vec<i32>>) -> Vec<i32> {
        let n = words.len();
        let mut prefix_counts: Vec<[usize; 26]> = vec![[0; 26]; n + 1];

        for i in 0..n {
            prefix_counts[i + 1].copy_from_slice(&prefix_counts[i]);
            for byte in words[i].bytes() {
                prefix_counts[i + 1][(byte - b'a') as usize] += 1;
            }
        }

        let mut results: Vec<i32> = Vec::with_capacity(queries.len());

        for query in queries {
            let l = query[0] as usize;
            let r = query[1] as usize;

            let mut current_counts = [0; 26];
            for char_idx in 0..26 {
                current_counts[char_idx] = prefix_counts[r + 1][char_idx] - prefix_counts[l][char_idx];
            }

            let mut total_pairs = 0;
            let mut total_odds = 0;

            for &count in current_counts.iter() {
                total_pairs += count / 2;
                total_odds += count % 2;
            }

            results.push((total_pairs + total_odds) as i32);
        }

        results
    }
}
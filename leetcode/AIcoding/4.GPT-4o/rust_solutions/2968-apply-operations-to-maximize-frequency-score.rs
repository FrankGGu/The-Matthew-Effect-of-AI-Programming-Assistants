impl Solution {
    pub fn maximize_freq_score(nums: Vec<i32>, k: i32) -> i32 {
        let mut count = std::collections::HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }

        let mut max_score = 0;
        for (num, freq) in count {
            let mut score = freq;
            let mut current_num = num;
            while current_num >= k {
                current_num -= k;
                score += *count.get(&current_num).unwrap_or(&0);
            }
            max_score = max_score.max(score);
        }

        max_score
    }
}
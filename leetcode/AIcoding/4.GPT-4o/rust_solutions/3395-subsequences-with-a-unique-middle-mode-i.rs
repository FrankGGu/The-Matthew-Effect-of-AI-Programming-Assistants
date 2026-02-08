impl Solution {
    pub fn count_unique_middle_mode_subsequences(nums: Vec<i32>) -> i32 {
        use std::collections::HashSet;
        let mut unique_subsequences = HashSet::new();
        let n = nums.len();

        for i in 0..(1 << n) {
            let mut subsequence = Vec::new();
            for j in 0..n {
                if (i & (1 << j)) != 0 {
                    subsequence.push(nums[j]);
                }
            }
            if !subsequence.is_empty() {
                let mut freq = std::collections::HashMap::new();
                for &num in &subsequence {
                    *freq.entry(num).or_insert(0) += 1;
                }
                let mut middle_mode = None;
                let mut max_freq = 0;
                for (&num, &count) in &freq {
                    if count > max_freq {
                        max_freq = count;
                        middle_mode = Some(num);
                    } else if count == max_freq {
                        middle_mode = None;
                    }
                }
                if middle_mode.is_some() {
                    unique_subsequences.insert(subsequence);
                }
            }
        }
        unique_subsequences.len() as i32
    }
}
use std::collections::HashMap;
use std::cmp::max;

impl Solution {
    pub fn max_equal_freq(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut counts: HashMap<i32, i32> = HashMap::new(); // Stores number -> frequency
        let mut freq_counts: HashMap<i32, i32> = HashMap::new(); // Stores frequency -> count of numbers with that frequency
        let mut max_freq = 0; // The maximum frequency observed so far
        let mut ans = 0;

        for i in 0..n {
            let num = nums[i];

            // 1. Update counts for the current number
            let old_freq = *counts.get(&num).unwrap_or(&0);

            // 2. Decrement old_freq in freq_counts if it existed
            if old_freq > 0 {
                *freq_counts.get_mut(&old_freq).unwrap() -= 1;
                if freq_counts[&old_freq] == 0 {
                    freq_counts.remove(&old_freq);
                }
            }

            // 3. Increment count for the current number
            let new_freq = old_freq + 1;
            counts.insert(num, new_freq);

            // 4. Increment new_freq in freq_counts
            *freq_counts.entry(new_freq).or_insert(0) += 1;

            // 5. Update max_freq
            // max_freq needs to be the actual maximum frequency present in `freq_counts`
            // Iterating keys is fine as freq_counts.len() is small (at most sqrt(2*N))
            max_freq = *freq_counts.keys().max().unwrap_or(&0);

            // 6. Check conditions for a valid prefix of length (i + 1)
            let len = (i + 1) as i32;

            // Condition 1: All elements appear once. (e.g., [1,2,3])
            // If max_freq is 1, it means every distinct element appears exactly once.
            // Removing any one element leaves all remaining elements appearing once.
            if max_freq == 1 {
                ans = len;
            }
            // Condition 2: Only one distinct element. (e.g., [1,1,1])
            // If there's only one distinct number, it must appear 'len' times.
            // Removing one instance of it leaves 'len-1' instances, all having the same frequency.
            else if counts.len() == 1 {
                ans = len;
            }
            // Condition 3: Exactly two distinct frequencies in freq_counts
            else if freq_counts.len() == 2 {
                // Get the two frequencies and their counts
                let mut freqs_and_counts: Vec<(i32, i32)> = freq_counts.iter().map(|(&f, &c)| (f, c)).collect();
                freqs_and_counts.sort_unstable(); // Sort by frequency for easier comparison

                let (f1, c1) = freqs_and_counts[0];
                let (f2, c2) = freqs_and_counts[1];

                // Subcase 3a: One element appears `max_freq` times, others appear `max_freq - 1` times.
                // Example: [1,1,2,2,2]. Frequencies: 1:2, 2:3. Here max_freq=3.
                // f1=2, c1=1 (for '1'); f2=3, c2=1 (for '2').
                // If we remove one instance of the element with frequency `max_freq`, all elements will have frequency `max_freq - 1`.
                if f2 == max_freq && c2 == 1 && f1 == max_freq - 1 {
                    ans = len;
                }
                // Subcase 3b: One element appears once, others appear `max_freq` times.
                // Example: [1,1,2,2,3]. Frequencies: 1:1, 2:2. Here max_freq=2.
                // f1=1, c1=1 (for '3'); f2=2, c2=2 (for '1' and '2').
                // If we remove the element that appears once, all remaining elements will have frequency `max_freq`.
                else if f1 == 1 && c1 == 1 && f2 == max_freq {
                    ans = len;
                }
            }
        }
        ans
    }
}
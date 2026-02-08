impl Solution {
    pub fn unequal_triplets(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = arr.len();
        let mut freq = std::collections::HashMap::new();

        for &num in &arr {
            *freq.entry(num).or_insert(0) += 1;
        }

        let unique_vals: Vec<_> = freq.keys().copied().collect();
        let unique_count = unique_vals.len();

        for i in 0..unique_count {
            for j in (i + 1)..unique_count {
                for k in (j + 1)..unique_count {
                    count += freq[&unique_vals[i]] * freq[&unique_vals[j]] * freq[&unique_vals[k]];
                }
            }
        }

        count
    }
}
use std::collections::HashSet;

impl Solution {
    pub fn count_triplets(arr: Vec<i32>) -> i32 {
        let mut count = 0;
        let n = arr.len();
        let mut prefix = vec![0; n + 1];

        for i in 0..n {
            prefix[i + 1] = prefix[i] ^ arr[i];
        }

        let mut seen = HashSet::new();

        for k in 0..n {
            for j in 0..=k {
                let x = prefix[k + 1] ^ prefix[j];
                seen.insert(x);
            }
            for i in 0..=k {
                let x = prefix[k + 1] ^ prefix[i];
                if seen.contains(&x) {
                    count += 1;
                }
            }
            seen.clear();
        }

        count
    }
}
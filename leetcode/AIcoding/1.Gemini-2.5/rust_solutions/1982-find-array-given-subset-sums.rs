use std::collections::BTreeMap;

impl Solution {
    pub fn find_array(mut sums: Vec<i32>) -> Vec<i32> {
        sums.sort_unstable();

        let n = sums.len().trailing_zeros() as usize;
        let mut ans = Vec::with_capacity(n);

        for _ in 0..n {
            let x = sums[1] - sums[0];

            let mut new_sums_pos = Vec::with_capacity(sums.len() / 2);
            let mut new_sums_neg = Vec::with_capacity(sums.len() / 2);

            let mut counts_pos: BTreeMap<i32, i32> = BTreeMap::new();
            for &s in &sums {
                *counts_pos.entry(s).or_insert(0) += 1;
            }
            let mut counts_neg = counts_pos.clone();

            // Try forming new_sums_pos (assuming x is the element)
            for &s in &sums {
                if *counts_pos.get(&s).unwrap_or(&0) > 0 {
                    *counts_pos.get_mut(&s).unwrap() -= 1;
                    *counts_pos.get_mut(&(s + x)).unwrap() -= 1;
                    new_sums_pos.push(s);
                }
            }

            // Try forming new_sums_neg (assuming -x is the element)
            for &s in &sums {
                if *counts_neg.get(&s).unwrap_or(&0) > 0 {
                    *counts_neg.get_mut(&s).unwrap() -= 1;
                    *counts_neg.get_mut(&(s - x)).unwrap() -= 1; // Note: s - x
                    new_sums_neg.push(s);
                }
            }

            // Decide which choice to make based on which resulting sum list contains 0
            if new_sums_pos.contains(&0) {
                ans.push(x);
                sums = new_sums_pos;
            } else {
                ans.push(-x);
                // If we chose -x, the new_sums_neg list contains sums 's' such that 's - x' was a sum from the previous level.
                // To get the actual sums for the next level (S_0), we need to shift them by '+x'.
                sums = new_sums_neg.into_iter().map(|s| s + x).collect();
                sums.sort_unstable(); // Ensure sorted order for the next iteration
            }
        }

        ans
    }
}
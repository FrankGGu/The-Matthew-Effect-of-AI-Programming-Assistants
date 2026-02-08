use std::collections::HashSet;

impl Solution {
    pub fn number_of_unique_xor_triplets(nums: Vec<i32>) -> i32 {
        let mut unique_set: HashSet<i32> = nums.into_iter().collect();
        let mut unique_values: Vec<i32> = unique_set.iter().cloned().collect();
        unique_values.sort_unstable();

        let n = unique_values.len();
        let mut triplets: HashSet<Vec<i32>> = HashSet::new();

        for i in 0..n {
            let a = unique_values[i];
            for j in i..n {
                let b = unique_values[j];
                let c = a ^ b;

                if unique_set.contains(&c) {
                    let mut triplet_vec = vec![a, b, c];
                    triplet_vec.sort_unstable();
                    triplets.insert(triplet_vec);
                }
            }
        }

        triplets.len() as i32
    }
}
impl Solution {
    pub fn fair_candy_swap(alice_sizes: Vec<i32>, bob_sizes: Vec<i32>) -> Vec<i32> {
        let sum_a: i32 = alice_sizes.iter().sum();
        let sum_b: i32 = bob_sizes.iter().sum();
        let diff = (sum_a - sum_b) / 2;

        let bob_set: std::collections::HashSet<i32> = bob_sizes.iter().cloned().collect();

        for &a in &alice_sizes {
            let b = a - diff;
            if bob_set.contains(&b) {
                return vec![a, b];
            }
        }

        vec![]
    }
}
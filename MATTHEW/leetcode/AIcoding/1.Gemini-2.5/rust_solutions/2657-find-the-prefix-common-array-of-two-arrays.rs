impl Solution {
    pub fn find_the_prefix_common_array(a: Vec<i32>, b: Vec<i32>) -> Vec<i32> {
        let n = a.len();
        let mut in_a = vec![false; n + 1];
        let mut in_b = vec![false; n + 1];
        let mut common_count = 0;
        let mut result = vec![0; n];

        for i in 0..n {
            let val_a = a[i] as usize;
            let val_b = b[i] as usize;

            // Process element from array A
            // If val_a was not seen in the prefix of A before this step
            if !in_a[val_a] {
                // If val_a was already seen in the prefix of B, it now becomes common
                if in_b[val_a] {
                    common_count += 1;
                }
                in_a[val_a] = true; // Mark val_a as seen in A's prefix
            }

            // Process element from array B
            // If val_b was not seen in the prefix of B before this step
            if !in_b[val_b] {
                // If val_b was already seen in the prefix of A, it now becomes common
                if in_a[val_b] {
                    common_count += 1;
                }
                in_b[val_b] = true; // Mark val_b as seen in B's prefix
            }

            result[i] = common_count;
        }

        result
    }
}
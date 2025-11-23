struct TreeAncestor {
    up: Vec<Vec<i32>>,
    max_log: usize,
}

impl TreeAncestor {
    fn new(n: i32, parent: Vec<i32>) -> Self {
        let n_usize = n as usize;
        // max_log should be large enough to cover the maximum possible k.
        // k can be up to n-1. log2(50000) is approximately 15.6.
        // So, we need powers of 2 up to 2^15. This means indices 0 to 15.
        // A max_log of 16 (for indices 0..15) or 17 (for 0..16) is sufficient.
        let max_log = 17; 

        let mut up = vec![vec![-1; max_log]; n_usize];

        // Initialize the 2^0-th ancestor (direct parent)
        for i in 0..n_usize {
            up[i][0] = parent[i];
        }

        // Compute 2^j-th ancestors using previously computed 2^(j-1)-th ancestors
        for j in 1..max_log {
            for i in 0..n_usize {
                if up[i][j - 1] != -1 {
                    let ancestor_2_pow_j_minus_1 = up[i][j - 1] as usize;
                    up[i][j] = up[ancestor_2_pow_j_minus_1][j - 1];
                }
            }
        }

        TreeAncestor { up, max_log }
    }

    fn get_kth_ancestor(&self, node: i32, mut k: i32) -> i32 {
        let mut current_node = node;

        // Iterate from the largest power of 2 down to 0
        for j in (0..self.max_log).rev() {
            if current_node == -1 {
                // If at any point current_node becomes -1, it means we've gone past the root
                // and no further ancestor exists.
                return -1;
            }
            // If the j-th bit of k is set, we need to jump 2^j steps
            if ((k >> j) & 1) == 1 {
                current_node = self.up[current_node as usize][j];
            }
        }

        current_node
    }
}
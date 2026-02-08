struct Solution;

impl Solution {
    pub fn the_nand_puzzle(n: i32, results: Vec<i32>) -> Vec<i32> {
        if n == 0 {
            return if results.len() == 1 && results[0] == 1 {
                vec![] // Empty 'a' for n=0
            } else {
                vec![]
            };
        }

        let mut a = vec![0; n as usize];
        let mut current_f = results;

        for k in (1..n as usize).rev() {
            let mut next_f = vec![0; 1 << k];
            let mut can_be_ak0 = true;
            let mut can_be_ak1 = true;

            for i in 0..(1 << k) {
                let val0 = current_f[i];
                let val1 = current_f[i + (1 << k)];

                // Check a_k = 0 possibility
                // If a_k = 0, then h_k(x_k) = 1.
                // f_k(..., x_k) = f_{k-1}(...) NAND 1 = NOT f_{k-1}(...).
                // So, f_k(..., 0) == f_k(..., 1) must hold.
                if val0 != val1 {
                    can_be_ak0 = false;
                }

                // Check a_k = 1 possibility
                // If a_k = 1, then h_k(x_k) = NOT x_k.
                // f_k(..., 0) = f_{k-1}(...) NAND (NOT 0) = f_{k-1}(...) NAND 1 = NOT f_{k-1}(...).
                // f_k(..., 1) = f_{k-1}(...) NAND (NOT 1) = f_{k-1}(...) NAND 0 = 1.
                // So, f_k(..., 1) must be 1.
                if val1 == 0 {
                    can_be_ak1 = false;
                }
            }

            if can_be_ak0 && can_be_ak1 {
                // Both a_k=0 and a_k=1 are possible. Arbitrarily choose a_k=0.
                a[k] = 0;
                for i in 0..(1 << k) {
                    // In both cases, f_{k-1}(i) = NOT f_k(i, 0) = 1 - current_f[i].
                    next_f[i] = 1 - current_f[i];
                }
            } else if can_be_ak0 {
                a[k] = 0;
                for i in 0..(1 << k) {
                    next_f[i] = 1 - current_f[i];
                }
            } else if can_be_ak1 {
                a[k] = 1;
                for i in 0..(1 << k) {
                    next_f[i] = 1 - current_f[i];
                }
            } else {
                // Neither a_k=0 nor a_k=1 is possible.
                return vec![];
            }
            current_f = next_f;
        }

        // After the loop, current_f has size 2. It represents f_0(x_0) = x_0 NAND a_0.
        let val0 = current_f[0]; // f_0(0)
        let val1 = current_f[1]; // f_0(1)

        // Determine a_0 from f_0(0) and f_0(1)
        // If a_0 = 0: f_0(x_0) = x_0 NAND 0 = 1. So [1, 1].
        // If a_0 = 1: f_0(x_0) = x_0 NAND 1 = NOT x_0. So [1, 0].
        if val0 == 1 && val1 == 1 {
            a[0] = 0;
        } else if val0 == 1 && val1 == 0 {
            a[0] = 1;
        } else {
            return vec![]; // No solution for a[0]
        }

        a
    }
}
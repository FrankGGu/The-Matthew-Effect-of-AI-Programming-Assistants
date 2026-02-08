impl Solution {
    fn n_choose_k(n: i32, k: i32) -> u64 {
        if k < 0 || k > n {
            return 0;
        }
        if k == 0 || k == n {
            return 1;
        }
        let k = k.min(n - k);
        let mut res = 1u64;
        for i in 0..k {
            res = res * (n - i) as u64 / (i + 1) as u64;
        }
        res
    }

    pub fn kth_smallest_path(destination: Vec<i32>, k: i32) -> String {
        let mut row = destination[0];
        let mut col = destination[1];
        let mut k = k as u64;
        let mut result = String::new();

        while row > 0 || col > 0 {
            if col > 0 {
                // Calculate the number of paths if we place an 'H' next.
                // Remaining steps: (row + col - 1)
                // Remaining 'H's: (col - 1)
                let paths_if_h = Self::n_choose_k(row + col - 1, col - 1);

                if k <= paths_if_h {
                    // Kth path starts with 'H'
                    result.push('H');
                    col -= 1;
                } else {
                    // Kth path starts with 'V'
                    result.push('V');
                    row -= 1;
                    k -= paths_if_h; // Adjust k for paths skipped
                }
            } else {
                // No more 'H's can be placed, must place 'V'
                result.push('V');
                row -= 1;
            }
        }
        result
    }
}
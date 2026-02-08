impl Solution {
    pub fn is_ideal_permutation(a: Vec<i32>) -> bool {
        let n = a.len();

        if n <= 2 {
            return true;
        }

        let mut suffix_min = vec![0; n];
        suffix_min[n - 1] = a[n - 1];

        for i in (0..n - 1).rev() {
            suffix_min[i] = a[i].min(suffix_min[i + 1]);
        }

        for i in 0..n - 2 {
            if a[i] > suffix_min[i + 2] {
                return false;
            }
        }

        true
    }
}
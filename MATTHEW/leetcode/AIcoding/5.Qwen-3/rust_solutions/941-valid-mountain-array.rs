struct Solution;

impl Solution {
    pub fn valid_mountainarray(a: Vec<i32>) -> bool {
        let n = a.len();
        if n < 3 {
            return false;
        }

        let mut i = 0;

        // Walk up
        while i + 1 < n && a[i] < a[i + 1] {
            i += 1;
        }

        // Peak can't be first or last
        if i == 0 || i == n - 1 {
            return false;
        }

        // Walk down
        while i + 1 < n && a[i] > a[i + 1] {
            i += 1;
        }

        i == n - 1
    }
}
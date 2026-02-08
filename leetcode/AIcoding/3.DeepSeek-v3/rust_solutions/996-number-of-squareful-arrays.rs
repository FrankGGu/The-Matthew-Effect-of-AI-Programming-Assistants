use std::collections::HashSet;

impl Solution {
    pub fn num_squareful_perms(a: Vec<i32>) -> i32 {
        let mut a = a;
        let mut count = 0;
        let n = a.len();
        Self::backtrack(&mut a, n, 0, &mut count);
        count
    }

    fn backtrack(a: &mut Vec<i32>, n: usize, start: usize, count: &mut i32) {
        if start == n {
            *count += 1;
            return;
        }
        let mut used = HashSet::new();
        for i in start..n {
            if used.contains(&a[i]) {
                continue;
            }
            used.insert(a[i]);
            a.swap(start, i);
            if start == 0 || Self::is_perfect_square(a[start - 1] + a[start]) {
                Self::backtrack(a, n, start + 1, count);
            }
            a.swap(start, i);
        }
    }

    fn is_perfect_square(sum: i32) -> bool {
        let root = (sum as f64).sqrt() as i32;
        root * root == sum
    }
}
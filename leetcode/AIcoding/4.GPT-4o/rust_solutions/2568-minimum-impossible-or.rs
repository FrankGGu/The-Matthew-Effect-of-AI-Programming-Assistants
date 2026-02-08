impl Solution {
    pub fn find_minimum_impossible_or(A: Vec<i32>) -> i32 {
        let mut impossible_or = 1;
        let mut seen = std::collections::HashSet::new();

        for &num in A.iter() {
            if num >= impossible_or {
                break;
            }
            seen.insert(num);
            if seen.contains(&(impossible_or - 1)) {
                impossible_or *= 2;
            }
        }

        impossible_or
    }
}
impl Solution {
    pub fn minimum_sum(n: i32, k: i32) -> i32 {
        let mut sum = 0;
        let mut used = std::collections::HashSet::new();
        let mut current = 1;

        for _ in 0..n {
            while used.contains(&(k - current)) {
                current += 1;
            }
            used.insert(current);
            sum += current;
            current += 1;
        }

        sum
    }
}
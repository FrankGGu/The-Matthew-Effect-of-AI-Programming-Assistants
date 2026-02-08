impl Solution {
    pub fn minimum_possible_sum(n: i32, target: i32) -> i64 {
        let mut used = std::collections::HashSet::new();
        let mut current = 1;
        let mut sum = 0i64;
        let mut count = 0;

        while count < n {
            if !used.contains(&(target - current)) {
                used.insert(current);
                sum += current as i64;
                count += 1;
            }
            current += 1;
        }

        sum
    }
}
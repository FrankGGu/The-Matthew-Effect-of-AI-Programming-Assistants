impl Solution {
    pub fn minimum_possible_sum(n: i32, target: i32) -> i64 {
        let mut sum = 0i64;
        let mut count = 0;
        let mut used = std::collections::HashSet::new();
        let mut i = 1;
        while count < n {
            if !used.contains(&i) {
                sum += i as i64;
                used.insert(target - i);
                count += 1;
            }
            i += 1;
        }
        sum
    }
}
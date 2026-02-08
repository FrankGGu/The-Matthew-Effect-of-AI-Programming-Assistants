impl Solution {
    pub fn minimum_sum(n: i32, k: i32) -> i32 {
        let mut sum = 0;
        let mut count = 0;
        let mut num = 1;
        let mut seen = std::collections::HashSet::new();

        while count < n {
            if !seen.contains(&(k - num)) {
                sum += num;
                seen.insert(num);
                count += 1;
            }
            num += 1;
        }

        sum
    }
}
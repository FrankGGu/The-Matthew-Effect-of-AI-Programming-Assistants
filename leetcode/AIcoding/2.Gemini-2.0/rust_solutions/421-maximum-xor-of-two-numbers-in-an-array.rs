impl Solution {
    pub fn find_maximum_xor(nums: Vec<i32>) -> i32 {
        let mut max_xor = 0;
        let mut mask = 0;
        let mut seen = std::collections::HashSet::new();

        for i in (0..31).rev() {
            mask |= 1 << i;
            seen.clear();
            for &num in &nums {
                seen.insert(num & mask);
            }

            let tentative_max = max_xor | (1 << i);
            for &prefix in &seen {
                if seen.contains(&(tentative_max ^ prefix)) {
                    max_xor = tentative_max;
                    break;
                }
            }
        }

        max_xor
    }
}
impl Solution {
    pub fn number_of_pairs(nums: Vec<String>) -> i32 {
        let mut count = 0;
        let mut seen = std::collections::HashSet::new();

        for num in nums {
            if seen.contains(&num) {
                count += 1;
            } else {
                seen.insert(num);
            }
        }

        count
    }
}
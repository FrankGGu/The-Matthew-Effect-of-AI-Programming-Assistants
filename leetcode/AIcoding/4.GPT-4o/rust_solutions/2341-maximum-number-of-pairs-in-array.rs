impl Solution {
    pub fn number_of_pairs(nums: Vec<i32>) -> Vec<i32> {
        let mut count = std::collections::HashMap::new();
        for &num in &nums {
            *count.entry(num).or_insert(0) += 1;
        }
        let mut pairs = 0;
        let mut leftovers = 0;
        for &v in count.values() {
            pairs += v / 2;
            leftovers += v % 2;
        }
        vec![pairs, leftovers]
    }
}
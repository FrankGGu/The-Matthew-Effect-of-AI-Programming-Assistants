impl Solution {
    pub fn sort_array_by_parity(nums: Vec<i32>) -> Vec<i32> {
        let mut evens = Vec::new();
        let mut odds = Vec::new();

        for &num in &nums {
            if num % 2 == 0 {
                evens.push(num);
            } else {
                odds.push(num);
            }
        }

        evens.extend(odds);
        evens
    }
}
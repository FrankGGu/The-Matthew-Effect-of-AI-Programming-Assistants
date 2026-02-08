impl Solution {
    pub fn find_outlier(nums: Vec<i32>) -> i32 {
        let mut evens = Vec::new();
        let mut odds = Vec::new();

        for &num in &nums {
            if num % 2 == 0 {
                evens.push(num);
            } else {
                odds.push(num);
            }
        }

        if evens.len() == 1 {
            evens[0]
        } else {
            odds[0]
        }
    }
}
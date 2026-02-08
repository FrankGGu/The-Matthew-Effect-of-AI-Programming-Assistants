impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let mut prev1 = 0;
        let mut prev2 = 0;
        for &num in &nums {
            let temp = prev1;
            prev1 = prev1.max(prev2 + num);
            prev2 = temp;
        }
        prev1
    }
}
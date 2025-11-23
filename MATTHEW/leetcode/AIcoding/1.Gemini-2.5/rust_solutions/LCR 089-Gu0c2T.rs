impl Solution {
    pub fn rob(nums: Vec<i32>) -> i32 {
        let mut prev2 = 0;
        let mut prev1 = 0;

        for num in nums {
            let current_max = (num + prev2).max(prev1);
            prev2 = prev1;
            prev1 = current_max;
        }

        prev1
    }
}
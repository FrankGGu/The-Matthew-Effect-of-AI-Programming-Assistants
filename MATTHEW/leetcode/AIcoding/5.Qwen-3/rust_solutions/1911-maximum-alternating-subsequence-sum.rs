pub struct Solution {}

impl Solution {
    pub fn max_alternating_subsequence_sum(nums: Vec<i32>) -> i32 {
        let mut even = 0;
        let mut odd = 0;

        for (i, &num) in nums.iter().enumerate() {
            if i % 2 == 0 {
                even = even.max(odd + num);
            } else {
                odd = odd.max(even + num);
            }
        }

        even.max(odd)
    }
}
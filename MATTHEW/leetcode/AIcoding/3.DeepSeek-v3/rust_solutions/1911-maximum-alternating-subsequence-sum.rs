impl Solution {
    pub fn max_alternating_sum(nums: Vec<i32>) -> i64 {
        let mut even = 0;
        let mut odd = 0;

        for num in nums {
            let new_even = std::cmp::max(even, odd + num as i64);
            let new_odd = std::cmp::max(odd, even - num as i64);
            even = new_even;
            odd = new_odd;
        }

        std::cmp::max(even, odd)
    }
}
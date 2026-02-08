struct Solution;

impl Solution {
    pub fn min_impossible_or(mut nums: Vec<i32>) -> i32 {
        nums.sort_unstable();

        let mut reachable_or_sum = 0;

        for num in nums {
            if num > reachable_or_sum + 1 {
                return reachable_or_sum + 1;
            }

            reachable_or_sum |= num;
        }

        reachable_or_sum + 1
    }
}
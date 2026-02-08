impl Solution {
    pub fn maximize_greatness(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut greatness = 0;
        let mut current = 0;

        for &num in &nums {
            if num > current {
                greatness += 1;
                current += 1;
            }
        }

        greatness
    }
}
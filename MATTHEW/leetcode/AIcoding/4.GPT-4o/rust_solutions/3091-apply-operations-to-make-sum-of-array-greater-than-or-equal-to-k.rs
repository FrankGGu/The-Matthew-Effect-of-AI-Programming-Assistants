impl Solution {
    pub fn min_operations(nums: Vec<i32>, k: i32) -> i32 {
        let mut nums = nums;
        nums.sort_unstable();
        let mut sum = 0;
        let mut operations = 0;

        for &num in nums.iter().rev() {
            sum += num;
            operations += 1;
            if sum >= k {
                return operations;
            }
        }
        -1
    }
}
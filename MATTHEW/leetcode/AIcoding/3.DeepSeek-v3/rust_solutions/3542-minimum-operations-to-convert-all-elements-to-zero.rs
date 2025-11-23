impl Solution {
    pub fn minimum_operations(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        let mut res = 0;
        let mut prev = 0;
        for &num in nums.iter() {
            if num > prev {
                res += 1;
                prev = num;
            }
        }
        res
    }
}
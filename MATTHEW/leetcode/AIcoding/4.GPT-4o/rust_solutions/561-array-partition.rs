impl Solution {
    pub fn array_pair_sum(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        nums.sort();
        nums.chunks(2).map(|x| x[0]).sum()
    }
}
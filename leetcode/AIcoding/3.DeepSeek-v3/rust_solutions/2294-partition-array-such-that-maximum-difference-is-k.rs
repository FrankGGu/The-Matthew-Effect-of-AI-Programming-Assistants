impl Solution {
    pub fn partition_array(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let mut res = 0;
        let mut i = 0;
        let n = nums.len();
        while i < n {
            let start = nums[i];
            let end = start + k;
            while i < n && nums[i] <= end {
                i += 1;
            }
            res += 1;
        }
        res
    }
}
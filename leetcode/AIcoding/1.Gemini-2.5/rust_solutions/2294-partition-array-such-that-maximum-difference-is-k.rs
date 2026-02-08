impl Solution {
    pub fn partition_array(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort_unstable();
        let mut count = 0;
        let n = nums.len();
        let mut i = 0;

        while i < n {
            count += 1;
            let min_val = nums[i];
            let mut j = i;
            while j < n && nums[j] - min_val <= k {
                j += 1;
            }
            i = j;
        }
        count
    }
}
impl Solution {
    pub fn partition_array(mut nums: Vec<i32>, k: i32) -> i32 {
        nums.sort();
        let mut count = 1;
        let mut start = nums[0];
        for i in 1..nums.len() {
            if nums[i] - start > k {
                count += 1;
                start = nums[i];
            }
        }
        count
    }
}
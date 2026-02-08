impl Solution {
    pub fn count_alternating_subarrays(nums: Vec<i32>) -> i64 {
        let mut res = 0;
        let mut count = 1;

        for i in 1..nums.len() {
            if nums[i] != nums[i - 1] {
                count += 1;
            } else {
                res += (count * (count + 1)) / 2;
                count = 1;
            }
        }
        res += (count * (count + 1)) / 2;
        res
    }
}
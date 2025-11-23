impl Solution {
    pub fn count_fair_pairs(nums: Vec<i32>, lower: i32, upper: i32) -> i64 {
        let mut nums = nums;
        nums.sort_unstable();
        let n = nums.len();
        let mut count = 0i64;

        for i in 0..n {
            let left = lower - nums[i];
            let right = upper - nums[i];

            let l = nums.partition_point(|&x| x < left);
            let r = nums.partition_point(|&x| x <= right);

            if r > i {
                count += (r - std::cmp::max(l, i + 1)) as i64;
            }
        }

        count
    }
}
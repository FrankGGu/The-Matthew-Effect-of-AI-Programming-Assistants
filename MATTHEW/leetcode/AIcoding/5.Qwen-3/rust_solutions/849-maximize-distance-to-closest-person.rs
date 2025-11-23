struct Solution;

impl Solution {
    pub fn max_dist_to_closest(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        let mut max_dist = 0;
        let mut prev = -1;

        for i in 0..n {
            if nums[i] == 1 {
                if prev != -1 {
                    max_dist = std::cmp::max(max_dist, (i as i32 - prev) / 2);
                } else {
                    max_dist = i as i32;
                }
                prev = i as i32;
            }
        }

        if prev != n as i32 - 1 {
            max_dist = std::cmp::max(max_dist, (n as i32 - 1 - prev));
        }

        max_dist
    }
}
impl Solution {
    pub fn min_impossible_integer(nums: Vec<i32>) -> i32 {
        let mut seen = std::collections::HashSet::new();
        for &num in &nums {
            if num <= nums.len() as i32 {
                seen.insert(num);
            }
        }

        for i in 1..=nums.len() as i32 + 1 {
            if !seen.contains(&i) {
                return i;
            }
        }

        return nums.len() as i32 + 1;
    }

    pub fn min_sum(nums1: Vec<i32>, nums2: Vec<i32>) -> i64 {
        let mut sum1: i64 = 0;
        let mut zeros1: i64 = 0;
        for &num in &nums1 {
            sum1 += num as i64;
            if num == 0 {
                zeros1 += 1;
            }
        }

        let mut sum2: i64 = 0;
        let mut zeros2: i64 = 0;
        for &num in &nums2 {
            sum2 += num as i64;
            if num == 0 {
                zeros2 += 1;
            }
        }

        if zeros1 == 0 && sum1 < sum2 + zeros2 {
            return -1;
        }
        if zeros2 == 0 && sum2 < sum1 + zeros1 {
            return -1;
        }

        let s1 = sum1 + zeros1;
        let s2 = sum2 + zeros2;

        std::cmp::max(s1, s2)
    }
}
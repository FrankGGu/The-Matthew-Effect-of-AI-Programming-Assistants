impl Solution {
    pub fn split_array(nums: Vec<i32>, k: i32) -> i32 {
        let mut left = *nums.iter().max().unwrap();
        let mut right = nums.iter().sum();
        let mut ans = right;

        while left <= right {
            let mid = left + (right - left) / 2;
            if Solution::is_possible(&nums, k, mid) {
                ans = mid;
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        ans
    }

    fn is_possible(nums: &Vec<i32>, k: i32, target: i32) -> bool {
        let mut count = 1;
        let mut sum = 0;
        for &num in nums {
            if sum + num > target {
                count += 1;
                sum = num;
            } else {
                sum += num;
            }
        }
        count <= k
    }
}
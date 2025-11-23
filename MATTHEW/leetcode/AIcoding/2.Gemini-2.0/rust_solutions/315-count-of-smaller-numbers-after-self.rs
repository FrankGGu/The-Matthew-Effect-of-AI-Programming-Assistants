impl Solution {
    pub fn count_smaller(nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();
        let mut counts = vec![0; n];
        let mut sorted = Vec::new();

        for i in (0..n).rev() {
            let num = nums[i];
            let mut left = 0;
            let mut right = sorted.len();

            while left < right {
                let mid = left + (right - left) / 2;
                if sorted[mid] < num {
                    left = mid + 1;
                } else {
                    right = mid;
                }
            }

            counts[i] = left as i32;
            sorted.insert(left, num);
        }

        counts
    }
}
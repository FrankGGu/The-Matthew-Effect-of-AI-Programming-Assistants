impl Solution {
    pub fn wiggle_sort(nums: &mut Vec<i32>) {
        let n = nums.len();
        let mut nums_sorted = nums.clone();
        nums_sorted.sort();
        let mid = (n + 1) / 2;
        let mut left = mid - 1;
        let mut right = n - 1;

        for i in (0..n).rev() {
            nums[i] = if i % 2 == 0 {
                nums_sorted[left]
            } else {
                nums_sorted[right]
            };

            if i % 2 == 0 {
                if left > 0 { left -= 1; }
            } else {
                right -= 1;
            }
        }
    }
}
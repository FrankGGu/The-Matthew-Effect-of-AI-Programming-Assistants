impl Solution {
    pub fn wiggle_sort(nums: &mut Vec<i32>) {
        let mut sorted = nums.clone();
        sorted.sort_unstable();
        let n = nums.len();
        let mut i = (n - 1) / 2;
        let mut j = n - 1;
        let mut k = 0;
        while k < n {
            if k % 2 == 0 {
                nums[k] = sorted[i];
                i -= 1;
            } else {
                nums[k] = sorted[j];
                j -= 1;
            }
            k += 1;
        }
    }
}
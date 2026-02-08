impl Solution {
    pub fn find_kth_largest(mut nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        let target_idx = n - k as usize;

        let mut low = 0;
        let mut high = n - 1;

        loop {
            let pivot_val = nums[high];
            let mut i = low;

            for j in low..high {
                if nums[j] <= pivot_val {
                    nums.swap(i, j);
                    i += 1;
                }
            }
            nums.swap(i, high);

            let pivot_idx = i;

            if pivot_idx == target_idx {
                return nums[pivot_idx];
            } else if pivot_idx < target_idx {
                low = pivot_idx + 1;
            } else {
                high = pivot_idx - 1;
            }
        }
    }
}
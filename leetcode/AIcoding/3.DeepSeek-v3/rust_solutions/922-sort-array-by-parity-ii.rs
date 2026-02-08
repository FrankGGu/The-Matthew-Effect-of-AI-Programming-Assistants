impl Solution {
    pub fn sort_array_by_parity_ii(nums: Vec<i32>) -> Vec<i32> {
        let mut nums = nums;
        let mut i = 0;
        let mut j = 1;
        let n = nums.len();

        while i < n && j < n {
            while i < n && nums[i] % 2 == 0 {
                i += 2;
            }
            while j < n && nums[j] % 2 == 1 {
                j += 2;
            }
            if i < n && j < n {
                nums.swap(i, j);
            }
        }

        nums
    }
}
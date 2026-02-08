impl Solution {
    pub fn next_permutation(nums: &mut Vec<i32>) {
        let n = nums.len();
        if n <= 1 {
            return;
        }

        let mut i = n - 2;
        while i >= 0 && nums[i] >= nums[i + 1] {
            i -= 1;
        }

        if i >= 0 {
            let mut j = n - 1;
            while j > i && nums[j] <= nums[i] {
                j -= 1;
            }
            nums.swap(i, j);
        }

        nums[i + 1..].reverse();
    }
}
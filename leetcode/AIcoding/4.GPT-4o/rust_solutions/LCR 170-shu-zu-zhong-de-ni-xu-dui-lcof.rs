impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let mut temp = vec![0; nums.len()];
        Self::merge_sort(&mut nums, &mut temp, 0, nums.len() as isize - 1)
    }

    fn merge_sort(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: isize, right: isize) -> i32 {
        if left >= right {
            return 0;
        }
        let mid = (left + right) / 2;
        let mut count = Self::merge_sort(nums, temp, left, mid) + Self::merge_sort(nums, temp, mid + 1, right);
        let (mut i, mut j) = (left, mid + 1);

        while i <= mid {
            while j <= right && nums[i as usize] > 2 * nums[j as usize] {
                j += 1;
            }
            count += j - (mid + 1);
            i += 1;
        }

        let (mut left_idx, mut right_idx) = (left, mid + 1);
        let mut k = left;

        while left_idx <= mid && right_idx <= right {
            if nums[left_idx as usize] <= nums[right_idx as usize] {
                temp[k as usize] = nums[left_idx as usize];
                left_idx += 1;
            } else {
                temp[k as usize] = nums[right_idx as usize];
                right_idx += 1;
            }
            k += 1;
        }

        while left_idx <= mid {
            temp[k as usize] = nums[left_idx as usize];
            left_idx += 1;
            k += 1;
        }

        while right_idx <= right {
            temp[k as usize] = nums[right_idx as usize];
            right_idx += 1;
            k += 1;
        }

        for i in left..=right {
            nums[i as usize] = temp[i as usize];
        }

        count
    }
}
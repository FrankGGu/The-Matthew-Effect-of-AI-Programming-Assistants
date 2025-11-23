impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let mut temp = vec![0; nums.len()];
        fn merge_sort(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: usize, right: usize) -> i32 {
            if left >= right {
                return 0;
            }
            let mid = left + (right - left) / 2;
            let mut count = merge_sort(nums, temp, left, mid) + merge_sort(nums, temp, mid + 1, right);
            let (mut j, mut k) = (mid + 1, left);
            for i in left..=mid {
                while j <= right && nums[i] > 2 * nums[j] {
                    j += 1;
                }
                count += (j - (mid + 1)) as i32;
            }
            j = left;
            for i in left..=right {
                if k > mid {
                    temp[i] = nums[j];
                    j += 1;
                } else if j > right {
                    temp[i] = nums[k];
                    k += 1;
                } else if nums[k] <= nums[j] {
                    temp[i] = nums[k];
                    k += 1;
                } else {
                    temp[i] = nums[j];
                    j += 1;
                }
            }
            nums[left..=right].copy_from_slice(&temp[left..=right]);
            count
        }
        merge_sort(&mut nums, &mut temp, 0, nums.len() - 1)
    }
}
impl Solution {
    pub fn count_inversions(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let mut temp = vec![0; nums.len()];
        Self::merge_sort(&mut nums, &mut temp, 0, nums.len() - 1) as i32
    }

    fn merge_sort(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: usize, right: usize) -> usize {
        if left >= right {
            return 0;
        }
        let mid = left + (right - left) / 2;
        let mut inv_count = 0;
        inv_count += Self::merge_sort(nums, temp, left, mid);
        inv_count += Self::merge_sort(nums, temp, mid + 1, right);
        inv_count += Self::merge(nums, temp, left, mid, right);
        inv_count
    }

    fn merge(nums: &mut Vec<i32>, temp: &mut Vec<i32>, left: usize, mid: usize, right: usize) -> usize {
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        let mut inv_count = 0;

        while i <= mid && j <= right {
            if nums[i] <= nums[j] {
                temp[k] = nums[i];
                i += 1;
            } else {
                temp[k] = nums[j];
                j += 1;
                inv_count += mid - i + 1;
            }
            k += 1;
        }

        while i <= mid {
            temp[k] = nums[i];
            i += 1;
            k += 1;
        }

        while j <= right {
            temp[k] = nums[j];
            j += 1;
            k += 1;
        }

        for i in left..=right {
            nums[i] = temp[i];
        }

        inv_count
    }
}
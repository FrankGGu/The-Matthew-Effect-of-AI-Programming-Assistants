impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        if n == 0 {
            return 0;
        }
        let mut temp = vec![0; n];
        Solution::merge_sort(&mut nums, 0, n - 1, &mut temp) as i32
    }

    fn merge_sort(nums: &mut Vec<i32>, left: usize, right: usize, temp: &mut Vec<i32>) -> usize {
        if left >= right {
            return 0;
        }
        let mid = left + (right - left) / 2;
        let mut count = Solution::merge_sort(nums, left, mid, temp) + Solution::merge_sort(nums, mid + 1, right, temp);
        let mut i = left;
        let mut j = mid + 1;
        while i <= mid && j <= right {
            if nums[i] as i64 > 2 * nums[j] as i64 {
                count += mid - i + 1;
                j += 1;
            } else {
                i += 1;
            }
        }
        Solution::merge(nums, left, mid, right, temp);
        count
    }

    fn merge(nums: &mut Vec<i32>, left: usize, mid: usize, right: usize, temp: &mut Vec<i32>) {
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        while i <= mid && j <= right {
            if nums[i] <= nums[j] {
                temp[k] = nums[i];
                i += 1;
            } else {
                temp[k] = nums[j];
                j += 1;
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
        for k in left..=right {
            nums[k] = temp[k];
        }
    }
}
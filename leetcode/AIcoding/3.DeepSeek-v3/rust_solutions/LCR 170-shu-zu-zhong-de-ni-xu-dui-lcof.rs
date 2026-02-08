impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        let n = nums.len();
        if n < 2 {
            return 0;
        }
        let mut temp = vec![0; n];
        Solution::merge_sort_and_count(&mut nums, 0, n - 1, &mut temp) as i32
    }

    fn merge_sort_and_count(nums: &mut Vec<i32>, left: usize, right: usize, temp: &mut Vec<i32>) -> usize {
        if left == right {
            return 0;
        }
        let mid = left + (right - left) / 2;
        let mut count = Solution::merge_sort_and_count(nums, left, mid, temp);
        count += Solution::merge_sort_and_count(nums, mid + 1, right, temp);
        if nums[mid] <= nums[mid + 1] {
            return count;
        }
        count += Solution::merge_and_count(nums, left, mid, right, temp);
        count
    }

    fn merge_and_count(nums: &mut Vec<i32>, left: usize, mid: usize, right: usize, temp: &mut Vec<i32>) -> usize {
        for i in left..=right {
            temp[i] = nums[i];
        }
        let mut i = left;
        let mut j = mid + 1;
        let mut count = 0;
        for k in left..=right {
            if i > mid {
                nums[k] = temp[j];
                j += 1;
            } else if j > right {
                nums[k] = temp[i];
                i += 1;
            } else if temp[i] <= temp[j] {
                nums[k] = temp[i];
                i += 1;
            } else {
                nums[k] = temp[j];
                j += 1;
                count += mid - i + 1;
            }
        }
        count
    }
}
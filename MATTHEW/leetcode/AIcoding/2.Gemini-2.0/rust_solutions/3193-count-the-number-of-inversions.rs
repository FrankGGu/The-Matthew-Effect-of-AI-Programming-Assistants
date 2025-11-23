impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        Self::merge_sort(&mut nums, 0, nums.len() - 1)
    }

    fn merge_sort(nums: &mut [i32], low: usize, high: usize) -> i32 {
        if low >= high {
            return 0;
        }
        let mid = low + (high - low) / 2;
        let mut count = Self::merge_sort(nums, low, mid);
        count += Self::merge_sort(nums, mid + 1, high);
        count += Self::count_reverse_pairs(nums, low, mid, high);
        Self::merge(nums, low, mid, high);
        count
    }

    fn count_reverse_pairs(nums: &mut [i32], low: usize, mid: usize, high: usize) -> i32 {
        let mut count = 0;
        let mut j = mid + 1;
        for i in low..=mid {
            while j <= high && nums[i] as i64 > 2 * nums[j] as i64 {
                j += 1;
            }
            count += (j - (mid + 1)) as i32;
        }
        count
    }

    fn merge(nums: &mut [i32], low: usize, mid: usize, high: usize) {
        let mut temp = Vec::new();
        let mut left = low;
        let mut right = mid + 1;

        while left <= mid && right <= high {
            if nums[left] <= nums[right] {
                temp.push(nums[left]);
                left += 1;
            } else {
                temp.push(nums[right]);
                right += 1;
            }
        }

        while left <= mid {
            temp.push(nums[left]);
            left += 1;
        }

        while right <= high {
            temp.push(nums[right]);
            right += 1;
        }

        for i in 0..(temp.len()) {
            nums[low + i] = temp[i];
        }
    }
}
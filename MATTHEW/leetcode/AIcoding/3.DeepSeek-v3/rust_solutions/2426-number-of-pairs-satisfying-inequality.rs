impl Solution {
    pub fn number_of_pairs(nums1: Vec<i32>, nums2: Vec<i32>, diff: i32) -> i64 {
        let n = nums1.len();
        let mut nums = Vec::with_capacity(n);
        for i in 0..n {
            nums.push(nums1[i] - nums2[i]);
        }
        let mut temp = vec![0; n];
        let mut count = 0i64;
        Self::merge_sort(&mut nums, 0, n - 1, &mut temp, diff, &mut count);
        count
    }

    fn merge_sort(nums: &mut Vec<i32>, left: usize, right: usize, temp: &mut Vec<i32>, diff: i32, count: &mut i64) {
        if left >= right {
            return;
        }
        let mid = left + (right - left) / 2;
        Self::merge_sort(nums, left, mid, temp, diff, count);
        Self::merge_sort(nums, mid + 1, right, temp, diff, count);
        Self::merge(nums, left, mid, right, temp, diff, count);
    }

    fn merge(nums: &mut Vec<i32>, left: usize, mid: usize, right: usize, temp: &mut Vec<i32>, diff: i32, count: &mut i64) {
        let mut i = left;
        let mut j = mid + 1;
        let mut k = left;
        let mut p = mid + 1;

        for l in left..=mid {
            while p <= right && nums[l] as i64 > nums[p] as i64 + diff as i64 {
                p += 1;
            }
            *count += (right - p + 1) as i64;
        }

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
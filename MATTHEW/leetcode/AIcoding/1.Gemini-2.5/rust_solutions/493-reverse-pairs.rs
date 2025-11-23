struct Solution;

impl Solution {
    pub fn reverse_pairs(nums: Vec<i32>) -> i32 {
        let mut nums = nums;
        Self::merge_sort(&mut nums, 0, (nums.len() as isize) - 1)
    }

    fn merge_sort(nums: &mut Vec<i32>, low: isize, high: isize) -> i32 {
        if low >= high {
            return 0;
        }

        let mid = low + (high - low) / 2;
        let mut count = Self::merge_sort(nums, low, mid) + Self::merge_sort(nums, mid + 1, high);

        // Count reverse pairs
        let mut j = mid + 1;
        for i in low..=mid {
            while j <= high && (nums[i as usize] as i64) > (2 * nums[j as usize] as i64) {
                j += 1;
            }
            count += (j - (mid + 1));
        }

        // Merge two sorted halves
        let mut temp = Vec::with_capacity((high - low + 1) as usize);
        let mut p1 = low;
        let mut p2 = mid + 1;

        while p1 <= mid && p2 <= high {
            if nums[p1 as usize] <= nums[p2 as usize] {
                temp.push(nums[p1 as usize]);
                p1 += 1;
            } else {
                temp.push(nums[p2 as usize]);
                p2 += 1;
            }
        }

        while p1 <= mid {
            temp.push(nums[p1 as usize]);
            p1 += 1;
        }

        while p2 <= high {
            temp.push(nums[p2 as usize]);
            p2 += 1;
        }

        for k in 0..temp.len() {
            nums[(low + k as isize) as usize] = temp[k];
        }

        count
    }
}
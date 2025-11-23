impl Solution {
    pub fn find_kth_largest(nums: Vec<i32>, k: i32) -> i32 {
        let n = nums.len();
        // The Kth largest element is at index (n - k) if the array were sorted in ascending order.
        let target_index = n - k as usize;

        let mut nums = nums; // Make the vector mutable for in-place partitioning

        Self::quick_select(&mut nums, 0, (n - 1) as i32, target_index as i32)
    }

    fn quick_select(nums: &mut Vec<i32>, left: i32, right: i32, k_index: i32) -> i32 {
        if left == right {
            return nums[left as usize];
        }

        let mut pivot_index = Self::partition(nums, left, right);

        if pivot_index == k_index {
            return nums[pivot_index as usize];
        } else if pivot_index < k_index {
            Self::quick_select(nums, pivot_index + 1, right, k_index)
        } else {
            Self::quick_select(nums, left, pivot_index - 1, k_index)
        }
    }

    fn partition(nums: &mut Vec<i32>, left: i32, right: i32) -> i32 {
        // Using the rightmost element as the pivot
        let pivot_value = nums[right as usize];
        let mut store_index = left;

        for i in left..right {
            if nums[i as usize] < pivot_value {
                nums.swap(store_index as usize, i as usize);
                store_index += 1;
            }
        }
        // Move the pivot to its final sorted position
        nums.swap(store_index as usize, right as usize);
        store_index
    }
}
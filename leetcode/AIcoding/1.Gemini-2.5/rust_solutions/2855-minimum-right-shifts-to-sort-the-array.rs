impl Solution {
    pub fn minimum_right_shifts(nums: Vec<i32>) -> i32 {
        let n = nums.len();
        if n <= 1 {
            return 0;
        }

        let mut descent_idx = -1;
        let mut descent_count = 0;

        for i in 0..n - 1 {
            if nums[i] > nums[i + 1] {
                descent_count += 1;
                descent_idx = i as i32;
            }
        }

        if descent_count == 0 {
            return 0;
        }

        if descent_count > 1 {
            return -1;
        }

        // Exactly one descent point at descent_idx.
        // For the array to be a valid rotation of a sorted array,
        // the last element must be less than the first element.
        // Example: [3, 4, 5, 1, 2]. Here nums[n-1]=2, nums[0]=3. 2 < 3. Valid.
        // Example: [2, 1, 3, 4]. Here nums[n-1]=4, nums[0]=2. 4 > 2. Invalid.
        if nums[n - 1] > nums[0] {
            return -1;
        }

        // The number of shifts required is the number of elements from
        // (descent_idx + 1) to (n - 1), which need to be moved to the front.
        (n - (descent_idx as usize + 1)) as i32
    }
}
impl Solution {
    pub fn apply_operations(mut nums: Vec<i32>) -> Vec<i32> {
        let n = nums.len();

        // First pass: Apply operations
        for i in 0..n.saturating_sub(1) {
            if nums[i] == nums[i+1] {
                nums[i] *= 2;
                nums[i+1] = 0;
            }
        }

        // Second pass: Move all zeros to the end
        let mut write_ptr = 0;
        for read_ptr in 0..n {
            if nums[read_ptr] != 0 {
                nums[write_ptr] = nums[read_ptr];
                write_ptr += 1;
            }
        }

        // Fill the remaining elements with zeros
        while write_ptr < n {
            nums[write_ptr] = 0;
            write_ptr += 1;
        }

        nums
    }
}
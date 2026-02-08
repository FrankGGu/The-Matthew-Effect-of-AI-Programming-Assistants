impl Solution {
    pub fn min_operations(nums: Vec<i32>) -> i32 {
        let mut operations = 0;
        let mut flip_parity = 0; // 0 for even number of active flips, 1 for odd

        for num in nums {
            // Calculate the effective value of the current element
            // If flip_parity is 0, the element is in its original state (num ^ 0 = num).
            // If flip_parity is 1, the element is flipped from its original state (num ^ 1).
            let effective_num = num ^ flip_parity;

            if effective_num == 0 {
                // If the effective value is 0, we must perform an operation starting at this index
                operations += 1;
                // Performing an operation flips this element and all subsequent elements.
                // This changes the net flip effect for all elements to the right.
                // So, toggle the flip_parity.
                flip_parity = 1 - flip_parity;
            }
        }

        operations
    }
}
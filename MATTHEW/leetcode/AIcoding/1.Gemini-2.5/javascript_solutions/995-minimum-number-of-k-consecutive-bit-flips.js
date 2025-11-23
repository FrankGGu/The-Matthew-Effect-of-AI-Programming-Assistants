var minKBitFlips = function(nums, k) {
    const n = nums.length;
    let flips = 0;
    let currentFlips = 0; // Tracks the number of active flips affecting the current position

    for (let i = 0; i < n; i++) {
        // If a flip that started at index (i - k) has moved out of the current window,
        // decrement currentFlips. We use nums[i - k] > 1 as a marker that a flip
        // was initiated at that index. Original values are 0 or 1.
        if (i >= k && nums[i - k] > 1) {
            currentFlips--;
        }

        // Determine the effective state of nums[i].
        // (nums[i] % 2) gives the original value (0 or 1).
        // (currentFlips % 2) tells if the bit is currently flipped an odd or even number of times
        // due to previous operations.
        // If (original_value ^ current_flip_parity) is 0, it means the bit is effectively 0
        // and needs to be flipped.
        if ((nums[i] % 2) === (currentFlips % 2)) {
            // If we need to flip but cannot form a window of size k (i.e., i + k is out of bounds),
            // it's impossible to make all bits 1.
            if (i + k > n) {
                return -1;
            }
            // Perform a flip
            flips++;
            currentFlips++;
            // Mark that a flip started at this position.
            // By adding 2, we change 0 to 2, and 1 to 3.
            // This allows us to later check if a flip started at nums[j] by checking nums[j] > 1,
            // while nums[j] % 2 still gives the original bit value.
            nums[i] += 2;
        }
    }

    return flips;
};
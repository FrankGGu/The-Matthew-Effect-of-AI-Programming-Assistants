var findKOr = function(nums, k) {
    let kOrResult = 0;

    // Iterate through bit positions from 0 up to 30.
    // Numbers up to 10^9 require up to 30 bits (2^29 < 10^9 < 2^30).
    for (let i = 0; i < 31; i++) { 
        let countSetBits = 0;

        // For each bit position, count how many numbers in nums have this bit set.
        for (let j = 0; j < nums.length; j++) {
            // Check if the i-th bit of nums[j] is set using bitwise right shift and AND.
            if ((nums[j] >> i) & 1) {
                countSetBits++;
            }
        }

        // If at least k numbers have the i-th bit set, then the i-th bit of the K-or result should be set.
        if (countSetBits >= k) {
            // Set the i-th bit in kOrResult using bitwise OR.
            kOrResult |= (1 << i);
        }
    }

    return kOrResult;
};
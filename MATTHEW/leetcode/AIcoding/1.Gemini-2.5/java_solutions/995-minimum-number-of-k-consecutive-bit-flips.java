class Solution {
    public int minKBitFlips(int[] nums, int k) {
        int n = nums.length;
        int flipCount = 0; // Tracks the number of active flips affecting the current position 'i'
        int res = 0;       // Stores the total number of flips performed

        for (int i = 0; i < n; i++) {
            // If a flip started at 'i - k', it means its effect ends before or at 'i-1'.
            // So, when we move to 'i', this flip is no longer active.
            // We marked a flip start by changing nums[j] to 2.
            if (i >= k && nums[i - k] == 2) {
                flipCount--;
            }

            // Determine the effective state of nums[i]
            // If nums[i] is 0 and flipCount is even, effective state is 0.
            // If nums[i] is 0 and flipCount is odd, effective state is 1.
            // If nums[i] is 1 and flipCount is even, effective state is 1.
            // If nums[i] is 1 and flipCount is odd, effective state is 0.
            // This can be concisely checked by (nums[i] + flipCount) % 2.
            // If this sum is 0, the current bit is effectively 0 and needs a flip.
            if ((nums[i] + flipCount) % 2 == 0) {
                // The current bit is effectively 0, so we must perform a flip starting at 'i'.

                // Check if a K-flip is possible from index 'i'.
                // If 'i + k' exceeds the array length 'n', it means we don't have 'k' bits.
                if (i + k > n) {
                    return -1; // Impossible to make all bits 1
                }

                res++;         // Increment total flip count
                flipCount++;   // Increment active flip count for subsequent positions
                // Mark that a flip started at index 'i'.
                // We use '2' as a marker because original nums[i] values are only 0 or 1.
                nums[i] = 2;
            }
        }

        return res;
    }
}
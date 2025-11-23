import java.util.Arrays;

class Solution {
    public int maximumTop(int[] nums, int k) {
        int n = nums.length;

        // Case 1: Array is empty (though constraints state 1 <= nums.length)
        if (n == 0) {
            return -1;
        }

        // Case 2: No moves allowed
        if (k == 0) {
            return nums[0];
        }

        // Case 3: Only one element in the array
        if (n == 1) {
            // If k is even, we can remove nums[0] and put it back k/2 times.
            // So nums[0] remains at the top.
            // If k is odd, we remove nums[0] (k-1)/2 times, then remove it one last time.
            // The array becomes empty.
            if (k % 2 == 0) {
                return nums[0];
            } else {
                return -1;
            }
        }

        // Case 4: More than one element in the array (n > 1) and k > 0 moves

        // If k is large enough to remove all elements (k >= n)
        if (k >= n) {
            // If k-n is even, we remove all n elements (n moves), then we have k-n even moves left.
            // We can put an element back (1 move), then remove it (1 move), (k-n)/2 times.
            // The stack will end up empty.
            if ((k - n) % 2 == 0) {
                return -1;
            } else {
                // If k-n is odd, we remove all n elements (n moves), then we have k-n odd moves left.
                // We can put an element back (1 move). We have k-n-1 even moves left.
                // We can keep the element at the top by removing and putting back (k-n-1)/2 times.
                // So, the maximum element from the original array can be at the top.
                int maxVal = 0; // Constraints: 0 <= nums[i] <= 10^9
                for (int x : nums) {
                    maxVal = Math.max(maxVal, x);
                }
                return maxVal;
            }
        }

        // Case 5: n > 1 and k < n
        // In this scenario, we cannot remove all elements.
        // We have two main strategies to maximize the topmost element:

        // Strategy A: Remove exactly k elements. The element at original index k becomes the topmost.
        // This is possible because k < n.
        int maxVal = nums[k]; // Initialize with nums[k] as a candidate

        // Strategy B: Remove some elements, including one we want to maximize, and then put that element back.
        // To put nums[i] (where i < k) back on top:
        // 1. Remove nums[0]...nums[i-1] (i moves). nums[i] is at the top.
        // 2. Remove nums[i] (1 move). nums[i] is now in the removed pile.
        // Total moves so far: i+1. Remaining moves: k - (i+1).
        // 3. Put nums[i] back (1 move). nums[i] is at the top.
        // Total moves so far: i+2. Remaining moves: k - (i+2).
        // For nums[i] to remain at the top, k - (i+2) must be non-negative and even.
        // This implies i <= k-2.
        // So, we iterate 'i' from 0 up to k-2 (inclusive).
        // For any such 'i', we can always achieve this by using the remaining k-(i+2) even moves
        // to remove and put back nums[i] (k-(i+2))/2 times.
        // We are looking for the maximum among these possible candidates.
        for (int i = 0; i < k - 1; i++) { // Loop iterates for i = 0, 1, ..., k-2
            maxVal = Math.max(maxVal, nums[i]);
        }

        return maxVal;
    }
}
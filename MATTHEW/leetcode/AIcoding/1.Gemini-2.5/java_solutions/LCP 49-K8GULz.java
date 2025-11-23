import java.util.Arrays;

class Solution {
    public int ringChallengeGame(int[] strength, long energy) {
        int n = strength.length;
        if (n == 0) {
            return 0;
        }

        // Create an extended array to handle circularity.
        // The array will be strength + strength.
        // We need to find the longest contiguous segment (subarray) in this extended array
        // that includes strength[0] (which is at index 'n' in the extended array)
        // and whose sum is less than or equal to 'energy'.
        long[] extendedStrength = new long[2 * n];
        for (int i = 0; i < 2 * n; i++) {
            extendedStrength[i] = strength[i % n];
        }

        int maxDistinct = 0;
        long currentSum = 0;
        int left = 0;

        // Iterate with 'right' pointer to expand the window
        for (int right = 0; right < 2 * n; right++) {
            currentSum += extendedStrength[right];

            // Shrink the window from 'left' if currentSum exceeds energy
            while (currentSum > energy) {
                currentSum -= extendedStrength[left];
                left++;
            }

            // Check if the current window [left, right] includes strength[0].
            // In the extendedStrength array, strength[0] appears at index 0 and index n.
            // We are interested in segments that contain the 'n'-th element (which is strength[0])
            // because this allows for segments that wrap around the original array,
            // e.g., [n-1, 0, 1] would correspond to [extendedStrength[n-1], extendedStrength[n], extendedStrength[n+1]].
            // The condition `left <= n && n <= right` ensures that the node corresponding to strength[0]
            // at index 'n' of the extended array is within the current window.
            if (left <= n && n <= right) {
                // The number of distinct elements is the length of the current valid window,
                // capped at 'n' because there are only 'n' unique levels in the game.
                maxDistinct = Math.max(maxDistinct, Math.min(n, right - left + 1));
            }
        }

        return maxDistinct;
    }
}
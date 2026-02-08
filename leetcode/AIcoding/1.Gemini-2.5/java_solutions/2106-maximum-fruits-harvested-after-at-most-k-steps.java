class Solution {
    public int maxTotalFruits(int[][] fruits, int startPos, int k) {
        // Calculate prefix sums for efficient range sum queries
        long[] prefixSum = new long[fruits.length + 1];
        // Store positions for easy access
        int[] positions = new int[fruits.length];

        for (int i = 0; i < fruits.length; i++) {
            positions[i] = fruits[i][0];
            prefixSum[i + 1] = prefixSum[i] + fruits[i][1];
        }

        int left = 0;
        long maxFruits = 0;

        // Iterate through all possible right endpoints of the harvest window
        for (int right = 0; right < fruits.length; right++) {
            long currentRightPos = positions[right];

            // Adjust the left endpoint of the window
            // while the current window [left, right] is invalid (cost > k)
            while (left <= right) {
                long currentLeftPos = positions[left];
                long cost;

                // Calculate the minimum steps required to cover the range [currentLeftPos, currentRightPos]
                // starting from startPos.
                if (currentRightPos < startPos) {
                    // All fruits are to the left of startPos. Must move left from startPos to currentLeftPos.
                    cost = (long)startPos - currentLeftPos;
                } else if (currentLeftPos > startPos) {
                    // All fruits are to the right of startPos. Must move right from startPos to currentRightPos.
                    cost = currentRightPos - (long)startPos;
                } else {
                    // startPos is within [currentLeftPos, currentRightPos].
                    // Option 1: Go left to currentLeftPos, then turn and go right to currentRightPos.
                    // Total steps = (distance from startPos to currentLeftPos) + (distance from currentLeftPos to currentRightPos)
                    long cost1 = ((long)startPos - currentLeftPos) + (currentRightPos - currentLeftPos);
                    // Option 2: Go right to currentRightPos, then turn and go left to currentLeftPos.
                    // Total steps = (distance from startPos to currentRightPos) + (distance from currentRightPos to currentLeftPos)
                    long cost2 = (currentRightPos - (long)startPos) + (currentRightPos - currentLeftPos);
                    cost = Math.min(cost1, cost2);
                }

                if (cost <= k) {
                    // The current window [left, right] is valid.
                    // Update maxFruits with the fruits in this window.
                    maxFruits = Math.max(maxFruits, prefixSum[right + 1] - prefixSum[left]);
                    // Since this window is valid, we try to expand it by moving 'right' further.
                    // So, break from the inner while loop and let the outer loop increment 'right'.
                    break;
                } else {
                    // The current window [left, right] is invalid (cost > k).
                    // Shrink the window from the left by moving 'left' pointer forward.
                    left++;
                }
            }
        }

        return (int) maxFruits;
    }
}
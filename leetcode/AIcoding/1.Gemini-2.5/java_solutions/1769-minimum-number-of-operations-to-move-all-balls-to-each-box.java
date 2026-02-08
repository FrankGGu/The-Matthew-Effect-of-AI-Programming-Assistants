class Solution {
    public int[] minOperations(String boxes) {
        int n = boxes.length();
        int[] ans = new int[n];

        // Pass 1: Calculate the cost of moving balls from left to the current box.
        // For each box 'i', costFromLeft represents the sum of distances from all '1's
        // at indices j < i to index i.
        // numBallsToLeft counts the number of '1's encountered so far (up to and including i-1).
        int numBallsToLeft = 0;
        int costFromLeft = 0;
        for (int i = 0; i < n; i++) {
            ans[i] += costFromLeft; // Add the cost accumulated from the left
            if (boxes.charAt(i) == '1') {
                numBallsToLeft++;
            }
            // For the next box (i+1), all 'numBallsToLeft' balls will be one step further away.
            costFromLeft += numBallsToLeft;
        }

        // Pass 2: Calculate the cost of moving balls from right to the current box.
        // For each box 'i', costFromRight represents the sum of distances from all '1's
        // at indices j > i to index i.
        // numBallsToRight counts the number of '1's encountered so far (from right to left, up to and including i+1).
        int numBallsToRight = 0;
        int costFromRight = 0;
        for (int i = n - 1; i >= 0; i--) {
            ans[i] += costFromRight; // Add the cost accumulated from the right
            if (boxes.charAt(i) == '1') {
                numBallsToRight++;
            }
            // For the next box (i-1), all 'numBallsToRight' balls will be one step further away.
            costFromRight += numBallsToRight;
        }

        return ans;
    }
}
class Solution {
    public int minimumSum(int[] nums) {
        int minElement = Integer.MAX_VALUE;

        for (int num : nums) {
            // Calculate the digital root of the current number.
            // The digital root is the single-digit value obtained by repeatedly
            // summing the digits of a number until a single digit remains.
            // For any positive integer N, its digital root is (N - 1) % 9 + 1.
            // If N is 0, its digital root is 0.
            int digitalRoot;
            if (num == 0) {
                digitalRoot = 0;
            } else {
                digitalRoot = (num - 1) % 9 + 1;
            }
            minElement = Math.min(minElement, digitalRoot);
        }

        return minElement;
    }
}
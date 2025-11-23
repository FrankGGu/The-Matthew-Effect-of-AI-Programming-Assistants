class Solution {
    public int numOfSubarrays(int[] arr, int k, int threshold) {
        int count = 0;
        int currentSum = 0;
        int targetSum = threshold * k;

        // Calculate the sum of the first window
        for (int i = 0; i < k; i++) {
            currentSum += arr[i];
        }

        // Check the first window
        if (currentSum >= targetSum) {
            count++;
        }

        // Slide the window
        for (int i = k; i < arr.length; i++) {
            currentSum += arr[i] - arr[i - k];
            if (currentSum >= targetSum) {
                count++;
            }
        }

        return count;
    }
}
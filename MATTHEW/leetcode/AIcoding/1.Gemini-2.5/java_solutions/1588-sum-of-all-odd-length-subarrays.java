class Solution {
    public int sumOddLengthSubarrays(int[] arr) {
        int totalSum = 0;
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            // For each element arr[i], calculate how many odd-length subarrays it is part of.
            // An element arr[i] can be the starting point of (n - i) subarrays.
            // An element arr[i] can be the ending point of (i + 1) subarrays.

            // The number of possible starting positions to the left of or at arr[i] is (i + 1).
            // These are indices 0, 1, ..., i.
            long leftChoices = i + 1;

            // The number of possible ending positions to the right of or at arr[i] is (n - i).
            // These are indices i, i+1, ..., n-1.
            long rightChoices = n - i;

            // The total number of subarrays that contain arr[i] is leftChoices * rightChoices.
            // Among these subarrays, the number of odd-length subarrays is given by the formula:
            // (total_occurrences + 1) / 2 using integer division, which is equivalent to ceil(total_occurrences / 2.0).
            long occurrences = (leftChoices * rightChoices + 1) / 2;

            totalSum += arr[i] * occurrences;
        }

        return totalSum;
    }
}
class Solution {
    public int sumOddLengthSubarrays(int[] arr) {
        int totalSum = 0;
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            int leftCount = i + 1;
            int rightCount = n - i;

            int totalOccurrences = leftCount * rightCount;
            int oddOccurrences = (totalOccurrences + 1) / 2;

            totalSum += arr[i] * oddOccurrences;
        }

        return totalSum;
    }
}
class Solution {
    public long sumOfSubarrayValues(int[] arr) {
        long totalSum = 0;
        int n = arr.length;

        for (int i = 0; i < n; i++) {
            long contribution = (long) arr[i] * (i + 1) * (n - i);
            totalSum += contribution;
        }

        return totalSum;
    }
}
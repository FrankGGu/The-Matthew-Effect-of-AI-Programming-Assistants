class Solution {
    public long xSum(int[] arr, int k) {
        long totalSum = 0;
        int n = arr.length;
        for (int i = 0; i <= n - k; i++) {
            long sum = 0;
            for (int j = i; j < i + k; j++) {
                sum += arr[j];
            }
            totalSum += sum;
        }
        return totalSum;
    }
}
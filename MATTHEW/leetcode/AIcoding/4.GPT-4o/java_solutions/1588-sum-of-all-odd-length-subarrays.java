class Solution {
    public int sumOddLengthSubarrays(int[] arr) {
        int totalSum = 0;
        int n = arr.length;

        for (int length = 1; length <= n; length += 2) {
            for (int start = 0; start <= n - length; start++) {
                for (int i = start; i < start + length; i++) {
                    totalSum += arr[i];
                }
            }
        }

        return totalSum;
    }
}
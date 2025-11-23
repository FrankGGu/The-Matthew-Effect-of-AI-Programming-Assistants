public class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        if (n == 0) return 0;
        if (n == 1) return arr[0];

        int[] dpNoDelete = new int[n];
        int[] dpWithDelete = new int[n];

        dpNoDelete[0] = arr[0];
        dpWithDelete[0] = Integer.MIN_VALUE;

        int maxSum = arr[0];

        for (int i = 1; i < n; i++) {
            dpNoDelete[i] = Math.max(arr[i], dpNoDelete[i - 1] + arr[i]);
            dpWithDelete[i] = Math.max(dpWithDelete[i - 1] + arr[i], dpNoDelete[i - 1]);
            maxSum = Math.max(maxSum, dpNoDelete[i], dpWithDelete[i]);
        }

        return maxSum;
    }
}
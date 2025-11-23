class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        if (n == 1) return arr[0];

        int[] noDelete = new int[n];
        int[] oneDelete = new int[n];

        noDelete[0] = arr[0];
        oneDelete[0] = 0;
        int max = arr[0];

        for (int i = 1; i < n; i++) {
            noDelete[i] = Math.max(arr[i], noDelete[i - 1] + arr[i]);
            oneDelete[i] = Math.max(noDelete[i - 1], oneDelete[i - 1] + arr[i]);
            max = Math.max(max, Math.max(noDelete[i], oneDelete[i]));
        }

        return max;
    }
}
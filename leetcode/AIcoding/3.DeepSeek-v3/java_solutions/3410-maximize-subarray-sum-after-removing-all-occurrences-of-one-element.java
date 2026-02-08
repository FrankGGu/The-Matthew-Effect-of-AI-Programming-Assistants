class Solution {
    public int maximumSum(int[] arr) {
        int n = arr.length;
        if (n == 1) return arr[0];

        int[] left = new int[n];
        int[] right = new int[n];

        left[0] = arr[0];
        for (int i = 1; i < n; i++) {
            left[i] = Math.max(arr[i], left[i - 1] + arr[i]);
        }

        right[n - 1] = arr[n - 1];
        for (int i = n - 2; i >= 0; i--) {
            right[i] = Math.max(arr[i], right[i + 1] + arr[i]);
        }

        int res = Integer.MIN_VALUE;
        for (int i = 0; i < n; i++) {
            if (i == 0) {
                res = Math.max(res, right[i + 1]);
            } else if (i == n - 1) {
                res = Math.max(res, left[i - 1]);
            } else {
                res = Math.max(res, Math.max(left[i - 1] + right[i + 1], Math.max(left[i - 1], right[i + 1])));
            }
            res = Math.max(res, left[i]);
        }

        return res;
    }
}
class Solution {
    public int[] kthSmallestPrimeFraction(int[] arr, int k) {
        int n = arr.length;
        double left = 0, right = 1;
        int[] result = new int[2];

        while (left <= right) {
            double mid = (left + right) / 2;
            int count = 0;
            int x = 0, y = 1;

            for (int i = 0, j = 1; i < n - 1; i++) {
                while (j < n && arr[i] > mid * arr[j]) {
                    j++;
                }
                count += n - j;
                if (j < n && arr[i] * y > arr[j] * x) {
                    x = arr[i];
                    y = arr[j];
                }
            }

            if (count == k) {
                result[0] = x;
                result[1] = y;
                return result;
            } else if (count < k) {
                left = mid;
            } else {
                right = mid;
            }
        }

        return result;
    }
}
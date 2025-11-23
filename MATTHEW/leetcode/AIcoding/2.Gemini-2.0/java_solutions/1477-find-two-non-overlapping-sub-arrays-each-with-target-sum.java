import java.util.Arrays;

class Solution {
    public int minSumOfLengths(int[] arr, int target) {
        int n = arr.length;
        int[] left = new int[n];
        int[] right = new int[n];

        Arrays.fill(left, Integer.MAX_VALUE);
        Arrays.fill(right, Integer.MAX_VALUE);

        int sum = 0;
        int start = 0;
        for (int i = 0; i < n; i++) {
            sum += arr[i];
            while (sum > target) {
                sum -= arr[start];
                start++;
            }
            if (sum == target) {
                if (start == 0) {
                    left[i] = i - start + 1;
                } else {
                    left[i] = Math.min(left[i - 1], i - start + 1);
                }
            } else {
                if (i > 0) {
                    left[i] = left[i - 1];
                }
            }
        }

        sum = 0;
        start = n - 1;
        for (int i = n - 1; i >= 0; i--) {
            sum += arr[i];
            while (sum > target) {
                sum -= arr[start];
                start--;
            }
            if (sum == target) {
                if (start == n - 1) {
                    right[i] = start - i + 1;
                } else {
                    right[i] = Math.min(right[i + 1], start - i + 1);
                }
            } else {
                if (i < n - 1) {
                    right[i] = right[i + 1];
                }
            }
        }

        int minSum = Integer.MAX_VALUE;
        for (int i = 0; i < n - 1; i++) {
            if (left[i] != Integer.MAX_VALUE && right[i + 1] != Integer.MAX_VALUE) {
                minSum = Math.min(minSum, left[i] + right[i + 1]);
            }
        }

        return minSum == Integer.MAX_VALUE ? -1 : minSum;
    }
}
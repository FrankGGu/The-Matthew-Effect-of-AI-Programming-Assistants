class Solution {
    public int findBestValue(int[] arr, int target) {
        int left = 0;
        int right = 0;
        for (int num : arr) {
            right = Math.max(right, num);
        }

        while (left < right) {
            int mid = left + (right - left) / 2;
            int sum = calculateSum(arr, mid);
            if (sum < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }

        int sum1 = calculateSum(arr, left - 1);
        int sum2 = calculateSum(arr, left);
        if (Math.abs(sum1 - target) <= Math.abs(sum2 - target)) {
            return left - 1;
        }
        return left;
    }

    private int calculateSum(int[] arr, int value) {
        int sum = 0;
        for (int num : arr) {
            sum += Math.min(num, value);
        }
        return sum;
    }
}
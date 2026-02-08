class Solution {
    public int findBestValue(int[] arr, int target) {
        int left = 0, right = 100000;
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (check(arr, mid) < target) {
                left = mid + 1;
            } else {
                right = mid;
            }
        }
        if (check(arr, left) - target >= target - check(arr, left - 1)) {
            return left - 1;
        }
        return left;
    }

    private int check(int[] arr, int x) {
        int sum = 0;
        for (int num : arr) {
            sum += Math.min(num, x);
        }
        return sum;
    }
}
class Solution {
    public int findBestValue(int[] arr, int target) {
        int left = 0, right = 0;
        for (int num : arr) {
            right = Math.max(right, num);
        }
        int ans = right;
        int diff = target;
        while (left <= right) {
            int mid = left + (right - left) / 2;
            int sum = 0;
            for (int num : arr) {
                sum += Math.min(num, mid);
            }
            int curDiff = Math.abs(sum - target);
            if (curDiff < diff) {
                diff = curDiff;
                ans = mid;
            } else if (curDiff == diff && mid < ans) {
                ans = mid;
            }
            if (sum > target) {
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }
        return ans;
    }
}
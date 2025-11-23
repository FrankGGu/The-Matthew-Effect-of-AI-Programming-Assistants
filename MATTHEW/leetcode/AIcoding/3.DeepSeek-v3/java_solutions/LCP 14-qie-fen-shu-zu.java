class Solution {
    public int splitArray(int[] nums, int m) {
        int left = 0, right = 0;
        for (int num : nums) {
            left = Math.max(left, num);
            right += num;
        }
        while (left < right) {
            int mid = left + (right - left) / 2;
            if (canSplit(nums, m, mid)) {
                right = mid;
            } else {
                left = mid + 1;
            }
        }
        return left;
    }

    private boolean canSplit(int[] nums, int m, int maxSum) {
        int sum = 0;
        int count = 1;
        for (int num : nums) {
            if (sum + num > maxSum) {
                sum = num;
                count++;
                if (count > m) {
                    return false;
                }
            } else {
                sum += num;
            }
        }
        return true;
    }
}
class Solution {
    public int minMoves(int[] nums, int k) {
        int n = nums.length;
        int[] ones = new int[n];
        int count = 0;

        for (int i = 0; i < n; i++) {
            if (nums[i] == 1) {
                ones[count++] = i;
            }
        }

        if (count < k) return -1;

        int res = Integer.MAX_VALUE;
        int mid = k / 2;

        for (int i = 0; i <= count - k; i++) {
            int left = ones[i + mid] - ones[i] - mid;
            int right = ones[i + k - 1] - ones[i + mid] - (k - mid - 1);
            res = Math.min(res, left + right);
        }

        return res;
    }
}
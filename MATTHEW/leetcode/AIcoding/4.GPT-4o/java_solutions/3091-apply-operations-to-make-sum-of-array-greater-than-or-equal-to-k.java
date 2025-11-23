class Solution {
    public int minOperations(int[] nums, int k) {
        int n = nums.length;
        int left = 0, right = 0, sum = 0, minOps = Integer.MAX_VALUE;

        while (right < n) {
            sum += nums[right];
            right++;

            while (sum >= k) {
                minOps = Math.min(minOps, right - left);
                sum -= nums[left];
                left++;
            }
        }

        return minOps == Integer.MAX_VALUE ? -1 : minOps;
    }
}
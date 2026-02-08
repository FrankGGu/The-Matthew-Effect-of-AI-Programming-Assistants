class Solution {
    public int jump(int[] nums) {
        int n = nums.length;
        int jumps = 0;
        int currentReach = 0;
        int maxReach = 0;

        for (int i = 0; i < n - 1; i++) {
            maxReach = Math.max(maxReach, i + nums[i]);
            if (i == currentReach) {
                jumps++;
                currentReach = maxReach;
            }
        }

        return jumps;
    }
}
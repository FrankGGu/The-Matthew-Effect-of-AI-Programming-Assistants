class Solution {
    public int jump(int[] nums) {
        int n = nums.length;
        int jumps = 0, currentReach = 0, nextReach = 0;
        for (int i = 0; i < n - 1; i++) {
            nextReach = Math.max(nextReach, i + nums[i]);
            if (i == currentReach) {
                jumps++;
                currentReach = nextReach;
                if (currentReach >= n - 1) {
                    break;
                }
            }
        }
        return jumps;
    }
}
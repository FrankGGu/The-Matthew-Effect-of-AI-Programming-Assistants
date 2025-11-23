class Solution {
    public int jump(int[] nums) {
        if (nums.length <= 1) {
            return 0;
        }

        int jumps = 0;
        int currentJumpEnd = 0;
        int farthestReach = 0;

        for (int i = 0; i < nums.length - 1; i++) {
            farthestReach = Math.max(farthestReach, i + nums[i]);

            if (i == currentJumpEnd) {
                jumps++;
                currentJumpEnd = farthestReach;

                if (currentJumpEnd >= nums.length - 1) {
                    break;
                }
            }
        }

        return jumps;
    }
}
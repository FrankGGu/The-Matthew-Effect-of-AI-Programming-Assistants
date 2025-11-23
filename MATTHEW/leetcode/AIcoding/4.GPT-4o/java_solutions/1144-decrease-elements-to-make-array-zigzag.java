class Solution {
    public int movesToMakeZigzag(int[] nums) {
        int n = nums.length;
        int evenMoves = 0, oddMoves = 0;

        for (int i = 0; i < n; i++) {
            int required = Integer.MAX_VALUE;
            if (i > 0) required = Math.min(required, nums[i - 1]);
            if (i < n - 1) required = Math.min(required, nums[i + 1]);
            if (i % 2 == 0) {
                if (nums[i] >= required) evenMoves += nums[i] - required + 1;
            } else {
                if (nums[i] >= required) oddMoves += nums[i] - required + 1;
            }
        }

        return Math.min(evenMoves, oddMoves);
    }
}
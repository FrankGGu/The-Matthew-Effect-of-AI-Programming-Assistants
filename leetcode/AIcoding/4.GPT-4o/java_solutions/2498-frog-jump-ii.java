class Solution {
    public int maxJump(int[] stones) {
        int maxJump = 0;
        for (int i = 1; i < stones.length; i++) {
            maxJump = Math.max(maxJump, stones[i] - stones[i - 1]);
        }
        return maxJump;
    }
}
class Solution {
    public int maxJump(int[] stones) {
        int n = stones.length;
        int maxDiff = 0;
        for (int i = 1; i < n; i++) {
            maxDiff = Math.max(maxDiff, stones[i] - stones[i - 1]);
        }

        int result = 0;
        for (int i = 1; i < n; i++) {
            result = Math.max(result, stones[i] - stones[i - 1]);
        }
        for (int i = 1; i < n - 1; i++) {
            result = Math.max(result, stones[i + 1] - stones[i - 1]);
        }

        return result;
    }
}
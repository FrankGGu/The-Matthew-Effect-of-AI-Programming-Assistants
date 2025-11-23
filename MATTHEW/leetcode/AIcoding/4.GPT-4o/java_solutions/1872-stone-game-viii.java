class Solution {
    public int stoneGameVIII(int[] stones) {
        int n = stones.length;
        for (int i = 1; i < n; i++) {
            stones[i] += stones[i - 1];
        }
        int maxScore = stones[n - 1];
        int result = maxScore;
        for (int i = n - 2; i > 0; i--) {
            result = Math.max(result, maxScore - stones[i]);
        }
        return result;
    }
}
class Solution {
    public int stoneGameVII(int[] stones) {
        int n = stones.length;
        int prefixSum = 0;
        for (int stone : stones) {
            prefixSum += stone;
        }
        int leftSum = 0, rightSum = prefixSum;
        int score = 0;

        for (int i = 0; i < n - 1; i++) {
            if (leftSum + stones[i] < rightSum - stones[i]) {
                leftSum += stones[i];
            } else {
                rightSum -= stones[i];
                score += rightSum;
            }
        }
        return score;
    }
}
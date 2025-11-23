class Solution {
    public int maxSum(int numOnes, int numZeroes, int numNegOnes) {
        return Math.min(numOnes, 1) + Math.max(0, numZeroes) * 0 + Math.max(0, numNegOnes) * (-1);
    }
}
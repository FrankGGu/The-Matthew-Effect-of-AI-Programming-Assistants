import java.util.Arrays;

class Solution {
    private int[] nums;
    private int nOperations; // Represents 'n' from the problem description (number of operations)
    private int[] memo;
    private int[][] gcdCache;
    private int numElements;

    public int maxScore(int[] nums) {
        this.nums = nums;
        this.numElements = nums.length;
        this.nOperations = numElements / 2;
        this.memo = new int[1 << numElements];
        Arrays.fill(memo, -1);

        precomputeGcd();

        return solve(0);
    }

    private int solve(int mask) {
        int currentOperation = Integer.bitCount(mask) / 2 + 1;

        if (currentOperation > nOperations) {
            return 0;
        }

        if (memo[mask] != -1) {
            return memo[mask];
        }

        int maxScore = 0;
        int firstUnusedIdx = -1;

        for (int i = 0; i < numElements; i++) {
            if ((mask & (1 << i)) == 0) {
                firstUnusedIdx = i;
                break;
            }
        }

        for (int secondUnusedIdx = firstUnusedIdx + 1; secondUnusedIdx < numElements; secondUnusedIdx++) {
            if ((mask & (1 << secondUnusedIdx)) == 0) {
                int newMask = mask | (1 << firstUnusedIdx) | (1 << secondUnusedIdx);
                int currentPairScore = currentOperation * gcdCache[firstUnusedIdx][secondUnusedIdx];
                maxScore = Math.max(maxScore, currentPairScore + solve(newMask));
            }
        }

        return memo[mask] = maxScore;
    }

    private void precomputeGcd() {
        gcdCache = new int[numElements][numElements];
        for (int i = 0; i < numElements; i++) {
            for (int j = i + 1; j < numElements; j++) {
                gcdCache[i][j] = gcd(nums[i], nums[j]);
                gcdCache[j][i] = gcdCache[i][j];
            }
        }
    }

    private int gcd(int a, int b) {
        while (b != 0) {
            int temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }
}
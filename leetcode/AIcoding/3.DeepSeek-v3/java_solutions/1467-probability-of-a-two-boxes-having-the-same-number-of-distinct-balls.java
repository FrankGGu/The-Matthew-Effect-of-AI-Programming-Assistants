class Solution {
    private int[] balls;
    private int totalBalls;
    private int[] fact;
    private int totalPermutations;

    public double getProbability(int[] balls) {
        this.balls = balls;
        this.totalBalls = 0;
        for (int ball : balls) {
            totalBalls += ball;
        }
        computeFactorials();
        int validPermutations = dfs(0, new int[balls.length], new int[balls.length], 0, 0);
        return (double) validPermutations / totalPermutations;
    }

    private void computeFactorials() {
        fact = new int[totalBalls + 1];
        fact[0] = 1;
        for (int i = 1; i <= totalBalls; i++) {
            fact[i] = fact[i - 1] * i;
        }
    }

    private int dfs(int idx, int[] box1, int[] box2, int count1, int count2) {
        if (idx == balls.length) {
            if (count1 != count2) {
                return 0;
            }
            int distinct1 = 0;
            int distinct2 = 0;
            for (int i = 0; i < balls.length; i++) {
                if (box1[i] > 0) {
                    distinct1++;
                }
                if (box2[i] > 0) {
                    distinct2++;
                }
            }
            if (distinct1 != distinct2) {
                return 0;
            }
            int permutations1 = fact[count1];
            for (int num : box1) {
                permutations1 /= fact[num];
            }
            int permutations2 = fact[count2];
            for (int num : box2) {
                permutations2 /= fact[num];
            }
            totalPermutations += permutations1 * permutations2;
            return permutations1 * permutations2;
        }
        int res = 0;
        for (int i = 0; i <= balls[idx]; i++) {
            box1[idx] = i;
            box2[idx] = balls[idx] - i;
            res += dfs(idx + 1, box1, box2, count1 + i, count2 + (balls[idx] - i));
        }
        return res;
    }
}
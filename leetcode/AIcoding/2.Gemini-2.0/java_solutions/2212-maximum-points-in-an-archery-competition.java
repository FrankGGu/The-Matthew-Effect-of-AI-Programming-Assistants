class Solution {
    public int[] maximumBobPoints(int numArrows, int[] aliceArrows) {
        int[] ans = new int[12];
        int maxScore = -1;

        for (int mask = 0; mask < (1 << 12); mask++) {
            int arrowsUsed = 0;
            int score = 0;
            int[] current = new int[12];

            for (int i = 0; i < 12; i++) {
                if ((mask & (1 << i)) != 0) {
                    arrowsUsed += aliceArrows[i] + 1;
                    score += i;
                    current[i] = aliceArrows[i] + 1;
                }
            }

            if (arrowsUsed <= numArrows) {
                if (score > maxScore) {
                    maxScore = score;
                    ans = current.clone();
                    ans[0] += (numArrows - arrowsUsed);
                }
            }
        }

        return ans;
    }
}
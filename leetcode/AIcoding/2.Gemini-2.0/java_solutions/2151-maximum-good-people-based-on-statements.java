class Solution {
    public int maximumGood(int[][] statements) {
        int n = statements.length;
        int maxGood = 0;

        for (int i = 0; i < (1 << n); i++) {
            int goodCount = 0;
            boolean consistent = true;

            for (int j = 0; j < n; j++) {
                if ((i >> j) % 2 == 1) {
                    goodCount++;
                }
            }

            for (int j = 0; j < n; j++) {
                if ((i >> j) % 2 == 1) {
                    for (int k = 0; k < n; k++) {
                        if (statements[j][k] != 2) {
                            boolean expected = (statements[j][k] == 1);
                            boolean actual = ((i >> k) % 2 == 1);
                            if (expected != actual) {
                                consistent = false;
                                break;
                            }
                        }
                    }
                    if (!consistent) {
                        break;
                    }
                }
            }

            if (consistent) {
                maxGood = Math.max(maxGood, goodCount);
            }
        }

        return maxGood;
    }
}
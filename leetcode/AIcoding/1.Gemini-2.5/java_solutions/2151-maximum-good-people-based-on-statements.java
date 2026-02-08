class Solution {
    public int maximumGood(int[][] statements) {
        int n = statements.length;
        int maxGoodCount = 0;

        // Iterate through all 2^n possible assignments of good/bad people
        // Each bit in 'mask' represents a person: 1 for good, 0 for bad
        for (int mask = 0; mask < (1 << n); mask++) {
            if (isConsistent(mask, statements)) {
                maxGoodCount = Math.max(maxGoodCount, Integer.bitCount(mask));
            }
        }

        return maxGoodCount;
    }

    private boolean isConsistent(int mask, int[][] statements) {
        int n = statements.length;

        for (int i = 0; i < n; i++) {
            // If person i is assumed to be good in this mask
            if (((mask >> i) & 1) == 1) {
                // Check all statements made by person i
                for (int j = 0; j < n; j++) {
                    // If person i makes a statement about person j
                    if (statements[i][j] != 2) {
                        // If person i says person j is bad (0)
                        // But person j is assumed to be good in this mask
                        if (statements[i][j] == 0 && ((mask >> j) & 1) == 1) {
                            return false; // Inconsistent
                        }
                        // If person i says person j is good (1)
                        // But person j is assumed to be bad in this mask
                        if (statements[i][j] == 1 && ((mask >> j) & 1) == 0) {
                            return false; // Inconsistent
                        }
                    }
                }
            }
        }
        return true; // All statements from assumed good people are consistent
    }
}
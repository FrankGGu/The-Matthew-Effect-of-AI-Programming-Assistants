class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length;
        if (n <= 1) {
            return 0;
        }
        int m = strs[0].length();

        boolean[] isSorted = new boolean[n - 1];
        int deletedColumns = 0;

        for (int j = 0; j < m; j++) {
            boolean canKeepColumn = true;
            for (int i = 0; i < n - 1; i++) {
                if (!isSorted[i]) {
                    if (strs[i].charAt(j) > strs[i + 1].charAt(j)) {
                        canKeepColumn = false;
                        break;
                    }
                }
            }

            if (!canKeepColumn) {
                deletedColumns++;
            } else {
                for (int i = 0; i < n - 1; i++) {
                    if (!isSorted[i]) {
                        if (strs[i].charAt(j) < strs[i + 1].charAt(j)) {
                            isSorted[i] = true;
                        }
                    }
                }

                boolean allPairsStrictlySorted = true;
                for (int i = 0; i < n - 1; i++) {
                    if (!isSorted[i]) {
                        allPairsStrictlySorted = false;
                        break;
                    }
                }
                if (allPairsStrictlySorted) {
                    return deletedColumns;
                }
            }
        }

        return deletedColumns;
    }
}
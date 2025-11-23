class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length;
        int m = strs[0].length();
        int res = 0;
        boolean[] sorted = new boolean[n];

        for (int j = 0; j < m; j++) {
            boolean canDelete = false;
            boolean[] newSorted = sorted.clone();

            for (int i = 1; i < n; i++) {
                if (!sorted[i] && strs[i].charAt(j) < strs[i - 1].charAt(j)) {
                    canDelete = true;
                    break;
                }
            }

            if (canDelete) {
                res++;
            } else {
                for (int i = 1; i < n; i++) {
                    if (!sorted[i] && strs[i].charAt(j) > strs[i - 1].charAt(j)) {
                        newSorted[i] = true;
                    }
                }
                sorted = newSorted;
            }
        }

        return res;
    }
}
class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length;
        int m = strs[0].length();
        int ans = 0;
        boolean[] sorted = new boolean[n - 1];

        for (int j = 0; j < m; j++) {
            boolean delete = false;
            for (int i = 0; i < n - 1; i++) {
                if (!sorted[i] && strs[i].charAt(j) > strs[i + 1].charAt(j)) {
                    delete = true;
                    break;
                }
            }

            if (delete) {
                ans++;
            } else {
                for (int i = 0; i < n - 1; i++) {
                    if (strs[i].charAt(j) < strs[i + 1].charAt(j)) {
                        sorted[i] = true;
                    }
                }
            }
        }

        return ans;
    }
}
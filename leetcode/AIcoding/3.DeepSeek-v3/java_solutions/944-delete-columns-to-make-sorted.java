class Solution {
    public int minDeletionSize(String[] strs) {
        int count = 0;
        int n = strs.length;
        int m = strs[0].length();

        for (int j = 0; j < m; j++) {
            for (int i = 1; i < n; i++) {
                if (strs[i].charAt(j) < strs[i - 1].charAt(j)) {
                    count++;
                    break;
                }
            }
        }

        return count;
    }
}
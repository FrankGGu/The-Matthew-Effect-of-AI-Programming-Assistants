class Solution {
    public int minDeletionSize(String[] strs) {
        int n = strs.length, m = strs[0].length();
        boolean[] delete = new boolean[m];
        int count = 0;

        for (int col = 0; col < m; col++) {
            for (int row = 1; row < n; row++) {
                if (!delete[col] && strs[row - 1].charAt(col) > strs[row].charAt(col)) {
                    delete[col] = true;
                    count++;
                    break;
                }
            }
        }

        return count;
    }
}
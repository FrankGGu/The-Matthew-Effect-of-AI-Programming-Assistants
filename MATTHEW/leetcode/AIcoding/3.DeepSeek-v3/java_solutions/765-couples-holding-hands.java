class Solution {
    public int minSwapsCouples(int[] row) {
        int n = row.length;
        int[] pos = new int[n];
        for (int i = 0; i < n; i++) {
            pos[row[i]] = i;
        }
        int res = 0;
        for (int i = 0; i < n; i += 2) {
            int x = row[i];
            int y = x ^ 1;
            if (row[i + 1] != y) {
                int j = pos[y];
                swap(row, i + 1, j);
                pos[row[i + 1]] = i + 1;
                pos[row[j]] = j;
                res++;
            }
        }
        return res;
    }

    private void swap(int[] row, int i, int j) {
        int temp = row[i];
        row[i] = row[j];
        row[j] = temp;
    }
}
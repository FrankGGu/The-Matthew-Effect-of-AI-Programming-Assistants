public class Solution {
    public int minSwapsCouples(int[] row) {
        int n = row.length;
        int[] pos = new int[n];
        for (int i = 0; i < n; i++) {
            pos[row[i]] = i;
        }

        int swaps = 0;
        for (int i = 0; i < n; i += 2) {
            int x = row[i];
            int y = x ^ 1;
            if (row[i + 1] != y) {
                int j = pos[y];
                pos[row[i + 1]] = j;
                pos[y] = i + 1;
                int temp = row[i + 1];
                row[i + 1] = row[j];
                row[j] = temp;
                swaps++;
            }
        }
        return swaps;
    }
}
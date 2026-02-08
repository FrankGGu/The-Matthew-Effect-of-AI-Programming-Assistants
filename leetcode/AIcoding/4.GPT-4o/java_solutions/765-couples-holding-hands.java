public class Solution {
    public int minSwapsCouples(int[] row) {
        int n = row.length / 2;
        int[] pos = new int[n];
        for (int i = 0; i < row.length; i++) {
            pos[row[i] / 2] = i;
        }
        int swaps = 0;
        for (int i = 0; i < row.length; i += 2) {
            int couple = row[i] ^ 1;
            if (row[i + 1] != couple) {
                swaps++;
                int couplePos = pos[couple];
                pos[row[i + 1] / 2] = couplePos;
                int temp = row[i + 1];
                row[i + 1] = row[couplePos];
                row[couplePos] = temp;
            }
        }
        return swaps;
    }
}
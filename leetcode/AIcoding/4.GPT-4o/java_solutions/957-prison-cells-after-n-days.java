public class Solution {
    public int[] prisonAfterNDays(int[] cells, int N) {
        N = N % 14 == 0 ? 14 : N % 14;
        for (int i = 0; i < N; i++) {
            int[] next = new int[8];
            for (int j = 1; j < 7; j++) {
                next[j] = cells[j - 1] == cells[j + 1] ? 1 : 0;
            }
            cells = next;
        }
        return cells;
    }
}
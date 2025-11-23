import java.util.*;

class Solution {
    public long[] countBlackBlocks(int m, int n, int[][] coordinates) {
        long[] ans = new long[5];
        Set<Long> set = new HashSet<>();
        for (int[] c : coordinates) {
            int x = c[0], y = c[1];
            for (int i = Math.max(0, x - 1); i <= Math.min(m - 2, x); i++) {
                for (int j = Math.max(0, y - 1); j <= Math.min(n - 2, y); j++) {
                    long key = (long) i * n + j;
                    if (!set.contains(key)) {
                        int count = 0;
                        if (isBlack(i, j, coordinates)) count++;
                        if (isBlack(i + 1, j, coordinates)) count++;
                        if (isBlack(i, j + 1, coordinates)) count++;
                        if (isBlack(i + 1, j + 1, coordinates)) count++;
                        ans[count]++;
                        set.add(key);
                    }
                }
            }
        }
        long total = (long) (m - 1) * (n - 1);
        long sum = 0;
        for (int i = 1; i <= 4; i++) {
            sum += ans[i];
        }
        ans[0] = total - sum;
        return ans;
    }

    private boolean isBlack(int x, int y, int[][] coordinates) {
        for (int[] c : coordinates) {
            if (c[0] == x && c[1] == y) {
                return true;
            }
        }
        return false;
    }
}
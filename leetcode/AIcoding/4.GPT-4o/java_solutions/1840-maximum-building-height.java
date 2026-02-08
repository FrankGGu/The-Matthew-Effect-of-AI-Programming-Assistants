import java.util.Arrays;

class Solution {
    public int maxBuilding(int n, int[][] restrictions) {
        if (n == 1) return 0;
        restrictions = Arrays.copyOf(restrictions, restrictions.length + 2);
        restrictions[restrictions.length - 2] = new int[]{1, 0};
        restrictions[restrictions.length - 1] = new int[]{n, 0};

        Arrays.sort(restrictions, (a, b) -> a[0] - b[0]);

        int m = restrictions.length;
        for (int i = 1; i < m; i++) {
            int dx = restrictions[i][0] - restrictions[i - 1][0];
            restrictions[i][1] = Math.max(restrictions[i][1], restrictions[i - 1][1] + dx);
        }

        for (int i = m - 2; i >= 0; i--) {
            int dx = restrictions[i + 1][0] - restrictions[i][0];
            restrictions[i][1] = Math.max(restrictions[i][1], restrictions[i + 1][1] - dx);
        }

        int res = 0;
        for (int i = 0; i < m - 1; i++) {
            int dx = restrictions[i + 1][0] - restrictions[i][0];
            int h1 = restrictions[i][1];
            int h2 = restrictions[i + 1][1];
            res = Math.max(res, (h1 + h2 + dx) / 2 + (h1 - h2 + dx) * (h1 - h2 + dx) / (8 * dx));
        }

        return res;
    }
}
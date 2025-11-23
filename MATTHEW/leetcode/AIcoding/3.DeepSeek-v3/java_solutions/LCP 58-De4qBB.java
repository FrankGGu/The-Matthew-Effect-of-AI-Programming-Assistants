class Solution {
    public int maxBuilding(int n, int[][] restrictions) {
        if (restrictions.length == 0) {
            return n - 1;
        }
        Arrays.sort(restrictions, (a, b) -> a[0] - b[0]);

        int m = restrictions.length;
        int[] left = new int[m];
        int[] right = new int[m];

        left[0] = Math.min(restrictions[0][1], restrictions[0][0] - 1);
        for (int i = 1; i < m; i++) {
            int prevPos = restrictions[i - 1][0];
            int prevHeight = left[i - 1];
            int currPos = restrictions[i][0];
            int currHeight = restrictions[i][1];
            left[i] = Math.min(currHeight, prevHeight + currPos - prevPos);
        }

        right[m - 1] = restrictions[m - 1][1];
        for (int i = m - 2; i >= 0; i--) {
            int nextPos = restrictions[i + 1][0];
            int nextHeight = right[i + 1];
            int currPos = restrictions[i][0];
            int currHeight = restrictions[i][1];
            right[i] = Math.min(currHeight, nextHeight + nextPos - currPos);
        }

        int res = 0;
        for (int i = 0; i < m; i++) {
            restrictions[i][1] = Math.min(left[i], right[i]);
            if (i == 0) {
                res = Math.max(res, restrictions[i][1] + restrictions[i][0] - 1);
            } else {
                int prevPos = restrictions[i - 1][0];
                int prevHeight = restrictions[i - 1][1];
                int currPos = restrictions[i][0];
                int currHeight = restrictions[i][1];
                int maxHeight = Math.max(prevHeight, currHeight) + (currPos - prevPos - Math.abs(prevHeight - currHeight)) / 2;
                res = Math.max(res, maxHeight);
            }
        }
        res = Math.max(res, restrictions[m - 1][1] + (n - restrictions[m - 1][0]));
        return res;
    }
}
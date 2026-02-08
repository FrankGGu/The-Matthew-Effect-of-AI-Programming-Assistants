class Solution {
    public int numberOfWays(int[][] points) {
        int n = points.length;
        int count = 0;

        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                if (i == j) {
                    continue;
                }

                int xi = points[i][0];
                int yi = points[i][1];
                int xj = points[j][0];
                int yj = points[j][1];

                if (xi <= xj && yi >= yj) {
                    count++;
                }
            }
        }
        return count;
    }
}
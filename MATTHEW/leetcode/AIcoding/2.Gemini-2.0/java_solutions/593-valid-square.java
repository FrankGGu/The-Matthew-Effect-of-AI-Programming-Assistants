class Solution {
    public boolean validSquare(int[] p1, int[] p2, int[] p3, int[] p4) {
        int[][] p = {p1, p2, p3, p4};
        long[] dist = new long[6];
        int k = 0;
        for (int i = 0; i < 4; i++) {
            for (int j = i + 1; j < 4; j++) {
                dist[k++] = distance(p[i], p[j]);
            }
        }
        Arrays.sort(dist);
        if (dist[0] == 0) return false;
        return dist[0] == dist[1] && dist[1] == dist[2] && dist[2] == dist[3] &&
               dist[4] == dist[5] && dist[4] == 2 * dist[0];
    }

    private long distance(int[] p1, int[] p2) {
        return (long)(p1[0] - p2[0]) * (p1[0] - p2[0]) + (long)(p1[1] - p2[1]) * (p1[1] - p2[1]);
    }
}
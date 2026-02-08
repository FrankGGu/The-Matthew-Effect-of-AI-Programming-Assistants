class Solution {
    public int maxDist(int[] p1, int[] p2) {
        int dx = Math.abs(p1[0] - p2[0]);
        int dy = Math.abs(p1[1] - p2[1]);
        return Math.max(dx, dy);
    }

    public int maxDistToClosest(int[] seats) {
        int n = seats.length;
        int prev = -1;
        int maxDist = 0;

        for (int i = 0; i < n; i++) {
            if (seats[i] == 1) {
                if (prev == -1) {
                    maxDist = i;
                } else {
                    maxDist = Math.max(maxDist, (i - prev) / 2);
                }
                prev = i;
            }
        }

        if (seats[n - 1] == 0) {
            maxDist = Math.max(maxDist, n - 1 - prev);
        }

        return maxDist;
    }
}
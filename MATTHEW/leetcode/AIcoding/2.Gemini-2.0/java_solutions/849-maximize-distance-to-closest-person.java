class Solution {
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

        if (prev != -1) {
            maxDist = Math.max(maxDist, n - 1 - prev);
        }

        return maxDist;
    }
}
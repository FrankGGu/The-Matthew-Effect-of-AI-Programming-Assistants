class Solution {
    public int maxDistToClosest(int[] seats) {
        int n = seats.length;
        int left = -1, maxDist = 0;

        for (int i = 0; i < n; i++) {
            if (seats[i] == 1) {
                if (left == -1) {
                    maxDist = i;
                } else {
                    maxDist = Math.max(maxDist, (i - left) / 2);
                }
                left = i;
            }
        }

        if (seats[n - 1] == 0) {
            maxDist = Math.max(maxDist, n - 1 - left);
        }

        return maxDist;
    }
}
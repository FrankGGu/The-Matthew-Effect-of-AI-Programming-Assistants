public class Solution {
    public int maxDistToClosest(int[] seats) {
        int n = seats.length;
        int max = 0;
        int prev = -1;

        for (int i = 0; i < n; i++) {
            if (seats[i] == 1) {
                if (prev != -1) {
                    max = Math.max(max, i - prev);
                } else {
                    max = i;
                }
                prev = i;
            }
        }

        return Math.max(max, n - 1 - prev);
    }
}
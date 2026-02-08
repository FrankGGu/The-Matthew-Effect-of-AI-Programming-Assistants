class Solution {
    public int maxDistToClosest(int[] seats) {
        int maxDist = 0, lastPerson = -1, n = seats.length;

        for (int i = 0; i < n; i++) {
            if (seats[i] == 1) {
                if (lastPerson == -1) {
                    maxDist = i; // Distance from the left edge
                } else {
                    int dist = (i - lastPerson) / 2; // Distance between two people
                    maxDist = Math.max(maxDist, dist);
                }
                lastPerson = i;
            }
        }

        // Check distance from the last person to the right edge
        if (lastPerson != -1) {
            maxDist = Math.max(maxDist, n - 1 - lastPerson);
        }

        return maxDist;
    }
}
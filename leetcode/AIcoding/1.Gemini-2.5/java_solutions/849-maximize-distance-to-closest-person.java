class Solution {
    public int maxDistToClosest(int[] seats) {
        int n = seats.length;
        int maxDistance = 0;

        int firstPerson = -1;
        for (int i = 0; i < n; i++) {
            if (seats[i] == 1) {
                firstPerson = i;
                break;
            }
        }

        maxDistance = firstPerson;

        int lastPerson = -1;
        for (int i = n - 1; i >= 0; i--) {
            if (seats[i] == 1) {
                lastPerson = i;
                break;
            }
        }

        maxDistance = Math.max(maxDistance, (n - 1) - lastPerson);

        int prevPerson = firstPerson;
        for (int i = firstPerson + 1; i <= lastPerson; i++) {
            if (seats[i] == 1) {
                maxDistance = Math.max(maxDistance, (i - prevPerson) / 2);
                prevPerson = i;
            }
        }

        return maxDistance;
    }
}
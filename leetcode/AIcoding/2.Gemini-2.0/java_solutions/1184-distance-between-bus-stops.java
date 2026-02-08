class Solution {
    public int distanceBetweenBusStops(int[] distance, int start, int destination) {
        int sum = 0;
        int clockwise = 0;
        int n = distance.length;
        for (int i = 0; i < n; i++) {
            sum += distance[i];
        }

        int i = start;
        while (i != destination) {
            clockwise += distance[i];
            i = (i + 1) % n;
        }

        return Math.min(clockwise, sum - clockwise);
    }
}
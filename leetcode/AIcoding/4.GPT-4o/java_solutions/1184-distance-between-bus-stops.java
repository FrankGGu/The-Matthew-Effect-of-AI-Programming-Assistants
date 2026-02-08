class Solution {
    public int distanceBetweenBusStops(int[] distance, int start, int destination) {
        if (start > destination) {
            int temp = start;
            start = destination;
            destination = temp;
        }
        int directDistance = 0;
        for (int i = start; i < destination; i++) {
            directDistance += distance[i];
        }
        int totalDistance = 0;
        for (int dist : distance) {
            totalDistance += dist;
        }
        return Math.min(directDistance, totalDistance - directDistance);
    }
}
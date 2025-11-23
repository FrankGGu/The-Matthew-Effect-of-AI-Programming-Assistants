class Solution {
    public int distanceBetweenBusStops(int[] distance, int start, int destination) {
        int total = 0;
        int clockwise = 0;
        int n = distance.length;
        for (int d : distance) {
            total += d;
        }
        if (start > destination) {
            int temp = start;
            start = destination;
            destination = temp;
        }
        for (int i = start; i < destination; i++) {
            clockwise += distance[i];
        }
        int counterClockwise = total - clockwise;
        return Math.min(clockwise, counterClockwise);
    }
}
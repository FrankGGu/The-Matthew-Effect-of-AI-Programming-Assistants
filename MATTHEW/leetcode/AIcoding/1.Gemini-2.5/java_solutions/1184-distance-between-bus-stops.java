class Solution {
    public int distanceBetweenBusStops(int[] distance, int start, int destination) {
        int totalDistance = 0;
        for (int dist : distance) {
            totalDistance += dist;
        }

        int path1Distance = 0;
        int current = start;
        while (current != destination) {
            path1Distance += distance[current];
            current = (current + 1) % distance.length;
        }

        int path2Distance = totalDistance - path1Distance;

        return Math.min(path1Distance, path2Distance);
    }
}
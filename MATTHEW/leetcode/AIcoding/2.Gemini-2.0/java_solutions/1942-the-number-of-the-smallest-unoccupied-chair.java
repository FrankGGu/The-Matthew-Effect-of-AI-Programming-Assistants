import java.util.HashMap;
import java.util.Map;
import java.util.PriorityQueue;

class Solution {
    public int smallestChair(int[][] times, int targetFriend) {
        int targetArrivalTime = times[targetFriend][0];
        int n = times.length;
        int[][] indexedTimes = new int[n][3];
        for (int i = 0; i < n; i++) {
            indexedTimes[i][0] = times[i][0];
            indexedTimes[i][1] = times[i][1];
            indexedTimes[i][2] = i;
        }

        java.util.Arrays.sort(indexedTimes, (a, b) -> a[0] - b[0]);

        PriorityQueue<Integer> availableChairs = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            availableChairs.offer(i);
        }

        PriorityQueue<int[]> occupiedChairs = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        Map<Integer, Integer> chairAssignments = new HashMap<>();

        for (int i = 0; i < n; i++) {
            while (!occupiedChairs.isEmpty() && occupiedChairs.peek()[0] <= indexedTimes[i][0]) {
                availableChairs.offer(occupiedChairs.poll()[1]);
            }

            int chair = availableChairs.poll();
            chairAssignments.put(indexedTimes[i][2], chair);
            occupiedChairs.offer(new int[]{indexedTimes[i][1], chair});

            if (indexedTimes[i][0] == targetArrivalTime) {
                return chair;
            }
        }

        return -1;
    }
}
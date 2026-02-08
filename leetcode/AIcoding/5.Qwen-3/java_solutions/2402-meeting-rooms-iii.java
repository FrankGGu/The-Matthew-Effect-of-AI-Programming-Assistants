public class Solution {

import java.util.*;

public class Solution {
    public int mostBookedRoom(int[][] meetings, int n) {
        Arrays.sort(meetings, (a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> endTimes = new PriorityQueue<>((a, b) -> a[0] == b[0] ? a[1] - b[1] : a[0] - b[0]);
        PriorityQueue<Integer> availableRooms = new PriorityQueue<>();

        for (int i = 0; i < n; i++) {
            availableRooms.add(i);
        }

        int[] count = new int[n];

        for (int[] meeting : meetings) {
            int start = meeting[0], end = meeting[1];

            while (!endTimes.isEmpty() && endTimes.peek()[0] <= start) {
                int[] room = endTimes.poll();
                availableRooms.add(room[1]);
            }

            if (availableRooms.isEmpty()) {
                int[] earliest = endTimes.poll();
                int roomId = earliest[1];
                count[roomId]++;
                endTimes.add(new int[]{end, roomId});
            } else {
                int roomId = availableRooms.poll();
                count[roomId]++;
                endTimes.add(new int[]{end, roomId});
            }
        }

        int maxCount = -1, result = 0;
        for (int i = 0; i < n; i++) {
            if (count[i] > maxCount) {
                maxCount = count[i];
                result = i;
            }
        }

        return result;
    }
}
}
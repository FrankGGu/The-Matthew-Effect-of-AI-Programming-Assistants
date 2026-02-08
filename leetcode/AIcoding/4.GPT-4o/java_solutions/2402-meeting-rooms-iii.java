import java.util.*;

public class Solution {
    public int mostBooked(int n, int[][] meetings) {
        Arrays.sort(meetings, Comparator.comparingInt(a -> a[0]));
        PriorityQueue<int[]> freeRooms = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        for (int i = 0; i < n; i++) {
            freeRooms.offer(new int[]{0, i});
        }
        int[] roomCount = new int[n];

        for (int[] meeting : meetings) {
            while (!freeRooms.isEmpty() && freeRooms.peek()[0] <= meeting[0]) {
                freeRooms.poll();
            }
            if (freeRooms.isEmpty()) {
                int[] nextMeeting = freeRooms.poll();
                roomCount[nextMeeting[1]]++;
                freeRooms.offer(new int[]{nextMeeting[0] + (meeting[1] - meeting[0]), nextMeeting[1]});
            } else {
                int[] room = freeRooms.poll();
                roomCount[room[1]]++;
                freeRooms.offer(new int[]{room[0] + (meeting[1] - meeting[0]), room[1]});
            }
        }

        int maxCount = 0, roomIndex = 0;
        for (int i = 0; i < n; i++) {
            if (roomCount[i] > maxCount) {
                maxCount = roomCount[i];
                roomIndex = i;
            }
        }

        return roomIndex;
    }
}
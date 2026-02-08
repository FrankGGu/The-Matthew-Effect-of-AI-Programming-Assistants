import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int mostBooked(int n, int[][] meetings) {
        Arrays.sort(meetings, (a, b) -> Integer.compare(a[0], b[0]));

        PriorityQueue<Integer> availableRooms = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            availableRooms.offer(i);
        }

        PriorityQueue<long[]> occupiedRooms = new PriorityQueue<>((a, b) -> {
            if (a[0] != b[0]) {
                return Long.compare(a[0], b[0]);
            }
            return Long.compare(a[1], b[1]);
        });

        int[] meetingCounts = new int[n];

        for (int[] meeting : meetings) {
            int start = meeting[0];
            int end = meeting[1];
            long duration = end - start;

            while (!occupiedRooms.isEmpty() && occupiedRooms.peek()[0] <= start) {
                long[] room = occupiedRooms.poll();
                int roomIdx = (int) room[1];
                availableRooms.offer(roomIdx);
            }

            long actualStartTime;
            int assignedRoomIdx;

            if (!availableRooms.isEmpty()) {
                assignedRoomIdx = availableRooms.poll();
                actualStartTime = start;
            } else {
                long[] earliestFreeRoom = occupiedRooms.poll();
                actualStartTime = earliestFreeRoom[0];
                assignedRoomIdx = (int) earliestFreeRoom[1];
            }

            long newRoomFreeTime = actualStartTime + duration;
            occupiedRooms.offer(new long[]{newRoomFreeTime, assignedRoomIdx});
            meetingCounts[assignedRoomIdx]++;
        }

        int maxMeetings = -1;
        int busiestRoomIdx = -1;
        for (int i = 0; i < n; i++) {
            if (meetingCounts[i] > maxMeetings) {
                maxMeetings = meetingCounts[i];
                busiestRoomIdx = i;
            }
        }

        return busiestRoomIdx;
    }
}
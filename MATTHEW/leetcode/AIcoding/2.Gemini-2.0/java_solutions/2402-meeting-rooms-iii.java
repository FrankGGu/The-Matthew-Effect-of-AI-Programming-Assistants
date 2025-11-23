import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int mostBooked(int n, int[][] meetings) {
        Arrays.sort(meetings, (a, b) -> a[0] - b[0]);
        long[] roomAvailability = new long[n];
        int[] roomBookings = new int[n];
        PriorityQueue<Integer> availableRooms = new PriorityQueue<>();
        for (int i = 0; i < n; i++) {
            availableRooms.offer(i);
        }

        for (int[] meeting : meetings) {
            int start = meeting[0];
            int end = meeting[1];

            while (!availableRooms.isEmpty() && roomAvailability[availableRooms.peek()] <= start) {
                availableRooms.poll();
            }

            PriorityQueue<int[]> occupiedRooms = new PriorityQueue<>((a, b) -> Long.compare(roomAvailability[a[0]], roomAvailability[b[0]]));
            for (int i = 0; i < n; i++) {
                if (roomAvailability[i] > start) {
                    occupiedRooms.offer(new int[]{i});
                }
            }

            while (!occupiedRooms.isEmpty() && roomAvailability[occupiedRooms.peek()[0]] <= start) {
                availableRooms.offer(occupiedRooms.poll()[0]);
            }

            if (!availableRooms.isEmpty()) {
                int room = availableRooms.poll();
                roomAvailability[room] = end;
                roomBookings[room]++;
            } else {
                int room = occupiedRooms.poll()[0];
                roomAvailability[room] += (end - start);
                roomBookings[room]++;
            }
        }

        int maxBookings = 0;
        int mostBookedRoom = 0;
        for (int i = 0; i < n; i++) {
            if (roomBookings[i] > maxBookings) {
                maxBookings = roomBookings[i];
                mostBookedRoom = i;
            }
        }

        return mostBookedRoom;
    }
}
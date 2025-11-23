import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] closestRoom(int[][] rooms, int[][] queries) {
        int n = rooms.length;
        int m = queries.length;
        int[] res = new int[m];
        Integer[] queryIndices = new Integer[m];
        for (int i = 0; i < m; i++) {
            queryIndices[i] = i;
        }
        Arrays.sort(queryIndices, (i, j) -> queries[j][1] - queries[i][1]);
        Arrays.sort(rooms, (a, b) -> b[1] - a[1]);

        PriorityQueue<Integer> pq = new PriorityQueue<>();
        int roomIndex = 0;

        for (int queryIndex : queryIndices) {
            int preferredId = queries[queryIndex][0];
            int minSize = queries[queryIndex][1];

            while (roomIndex < n && rooms[roomIndex][1] >= minSize) {
                pq.offer(rooms[roomIndex][0]);
                roomIndex++;
            }

            int closestRoomId = -1;
            int minDiff = Integer.MAX_VALUE;

            for (Integer roomId : pq) {
                int diff = Math.abs(roomId - preferredId);
                if (diff < minDiff) {
                    minDiff = diff;
                    closestRoomId = roomId;
                } else if (diff == minDiff && roomId < closestRoomId) {
                    closestRoomId = roomId;
                }
            }

            res[queryIndex] = closestRoomId;
        }

        return res;
    }
}
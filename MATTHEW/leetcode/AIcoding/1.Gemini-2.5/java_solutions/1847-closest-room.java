import java.util.Arrays;
import java.util.TreeSet;

class Solution {
    public int[] closestRoom(int[][] rooms, int[][] queries) {
        int[][] indexedQueries = new int[queries.length][3];
        for (int i = 0; i < queries.length; i++) {
            indexedQueries[i][0] = queries[i][0];
            indexedQueries[i][1] = queries[i][1];
            indexedQueries[i][2] = i;
        }

        Arrays.sort(rooms, (a, b) -> b[1] - a[1]);

        Arrays.sort(indexedQueries, (a, b) -> b[1] - a[1]);

        int[] ans = new int[queries.length];
        TreeSet<Integer> availableRoomIds = new TreeSet<>();
        int roomPointer = 0;

        for (int[] query : indexedQueries) {
            int preferredId = query[0];
            int minSize = query[1];
            int originalIndex = query[2];

            while (roomPointer < rooms.length && rooms[roomPointer][1] >= minSize) {
                availableRoomIds.add(rooms[roomPointer][0]);
                roomPointer++;
            }

            int bestRoomId = -1;
            int minDiff = Integer.MAX_VALUE;

            Integer floorId = availableRoomIds.floor(preferredId);
            Integer ceilId = availableRoomIds.ceiling(preferredId);

            if (floorId != null) {
                int diff = preferredId - floorId;
                if (diff < minDiff) {
                    minDiff = diff;
                    bestRoomId = floorId;
                } else if (diff == minDiff) {
                    bestRoomId = Math.min(bestRoomId, floorId);
                }
            }

            if (ceilId != null) {
                int diff = ceilId - preferredId;
                if (diff < minDiff) {
                    minDiff = diff;
                    bestRoomId = ceilId;
                } else if (diff == minDiff) {
                    bestRoomId = Math.min(bestRoomId, ceilId);
                }
            }

            ans[originalIndex] = bestRoomId;
        }

        return ans;
    }
}
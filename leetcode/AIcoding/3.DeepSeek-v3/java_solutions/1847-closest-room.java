import java.util.Arrays;
import java.util.TreeSet;

class Solution {
    public int[] closestRoom(int[][] rooms, int[][] queries) {
        int n = rooms.length;
        int m = queries.length;
        int[][] sortedQueries = new int[m][3];
        for (int i = 0; i < m; i++) {
            sortedQueries[i][0] = queries[i][0];
            sortedQueries[i][1] = queries[i][1];
            sortedQueries[i][2] = i;
        }
        Arrays.sort(sortedQueries, (a, b) -> b[1] - a[1]);
        Arrays.sort(rooms, (a, b) -> b[1] - a[1]);
        TreeSet<Integer> roomIds = new TreeSet<>();
        int[] result = new int[m];
        int i = 0;
        for (int[] query : sortedQueries) {
            int preferred = query[0];
            int minSize = query[1];
            int idx = query[2];
            while (i < n && rooms[i][1] >= minSize) {
                roomIds.add(rooms[i][0]);
                i++;
            }
            Integer floor = roomIds.floor(preferred);
            Integer ceiling = roomIds.ceiling(preferred);
            int res = -1;
            if (floor != null && ceiling != null) {
                if (preferred - floor <= ceiling - preferred) {
                    res = floor;
                } else {
                    res = ceiling;
                }
            } else if (floor != null) {
                res = floor;
            } else if (ceiling != null) {
                res = ceiling;
            }
            result[idx] = res;
        }
        return result;
    }
}
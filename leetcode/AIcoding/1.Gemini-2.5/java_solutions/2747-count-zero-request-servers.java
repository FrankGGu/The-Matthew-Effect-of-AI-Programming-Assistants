import java.util.Arrays;
import java.util.Comparator;
import java.util.HashMap;
import java.util.Map;

class Solution {

    private static class Query {
        long time;
        int originalIndex;

        Query(long time, int originalIndex) {
            this.time = time;
            this.originalIndex = originalIndex;
        }
    }

    public int[] countServers(int n, int[][] logs, int x, int[] queries) {
        Arrays.sort(logs, Comparator.comparingInt(a -> a[1]));

        Query[] sortedQueries = new Query[queries.length];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i] = new Query(queries[i], i);
        }
        Arrays.sort(sortedQueries, Comparator.comparingLong(q -> q.time));

        int[] ans = new int[queries.length];
        Map<Integer, Integer> serverRequestCounts = new HashMap<>();
        int activeServersCount = 0;
        int left = 0;
        int right = 0;

        for (Query currentQuery : sortedQueries) {
            long queryTime = currentQuery.time;
            int originalIndex = currentQuery.originalIndex;

            long windowStart = queryTime - x;
            long windowEnd = queryTime;

            while (right < logs.length && logs[right][1] <= windowEnd) {
                int serverId = logs[right][0];
                serverRequestCounts.put(serverId, serverRequestCounts.getOrDefault(serverId, 0) + 1);
                if (serverRequestCounts.get(serverId) == 1) {
                    activeServersCount++;
                }
                right++;
            }

            while (left < logs.length && logs[left][1] < windowStart) {
                int serverId = logs[left][0];
                serverRequestCounts.put(serverId, serverRequestCounts.get(serverId) - 1);
                if (serverRequestCounts.get(serverId) == 0) {
                    activeServersCount--;
                    serverRequestCounts.remove(serverId);
                }
                left++;
            }

            ans[originalIndex] = n - activeServersCount;
        }

        return ans;
    }
}
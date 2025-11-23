import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        int[][] indexedQueries = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            indexedQueries[i][0] = queries[i];
            indexedQueries[i][1] = i;
        }
        Arrays.sort(indexedQueries, (a, b) -> a[0] - b[0]);

        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);

        int[] ans = new int[queries.length];
        Arrays.fill(ans, -1);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]); // Stores [interval_size, interval_end]

        int intervalPointer = 0;

        for (int i = 0; i < indexedQueries.length; i++) {
            int currentQueryValue = indexedQueries[i][0];
            int originalQueryIndex = indexedQueries[i][1];

            while (intervalPointer < intervals.length && intervals[intervalPointer][0] <= currentQueryValue) {
                int start = intervals[intervalPointer][0];
                int end = intervals[intervalPointer][1];
                int size = end - start + 1;
                pq.offer(new int[]{size, end});
                intervalPointer++;
            }

            while (!pq.isEmpty() && pq.peek()[1] < currentQueryValue) {
                pq.poll();
            }

            if (!pq.isEmpty()) {
                ans[originalQueryIndex] = pq.peek()[0];
            }
        }

        return ans;
    }
}
public class Solution {

import java.util.*;

public class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        int[] res = new int[queries.length];
        int[][] sortedQueries = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            sortedQueries[i][0] = queries[i];
            sortedQueries[i][1] = i;
        }
        Arrays.sort(sortedQueries, (a, b) -> a[0] - b[0]);

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[1] - b[1]);
        int idx = 0;
        for (int[] q : sortedQueries) {
            int queryVal = q[0], queryIdx = q[1];
            while (idx < intervals.length && intervals[idx][0] <= queryVal) {
                pq.offer(new int[]{intervals[idx][1], intervals[idx][0]});
                idx++;
            }
            while (!pq.isEmpty() && pq.peek()[1] < queryVal) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                res[queryIdx] = pq.peek()[0] - pq.peek()[1] + 1;
            } else {
                res[queryIdx] = -1;
            }
        }
        return res;
    }
}
}
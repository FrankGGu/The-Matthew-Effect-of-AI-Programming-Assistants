import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        int n = intervals.length;
        int m = queries.length;
        int[] res = new int[m];
        Integer[] qIndex = new Integer[m];
        for (int i = 0; i < m; i++) {
            qIndex[i] = i;
        }
        Arrays.sort(qIndex, (a, b) -> queries[a] - queries[b]);
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (a[1] - a[0] + 1) - (b[1] - b[0] + 1));
        int i = 0;
        for (int q : qIndex) {
            int query = queries[q];
            while (i < n && intervals[i][0] <= query) {
                pq.offer(intervals[i++]);
            }
            while (!pq.isEmpty() && pq.peek()[1] < query) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                res[q] = pq.peek()[1] - pq.peek()[0] + 1;
            } else {
                res[q] = -1;
            }
        }
        return res;
    }
}
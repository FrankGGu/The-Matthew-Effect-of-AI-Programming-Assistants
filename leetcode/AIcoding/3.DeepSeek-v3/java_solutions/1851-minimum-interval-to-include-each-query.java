import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        int[][] qs = new int[queries.length][2];
        for (int i = 0; i < queries.length; i++) {
            qs[i] = new int[]{queries[i], i};
        }
        Arrays.sort(qs, (a, b) -> a[0] - b[0]);
        Arrays.sort(intervals, (a, b) -> a[0] - b[0]);
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> (a[1] - a[0]) - (b[1] - b[0]));
        int[] res = new int[queries.length];
        int j = 0;
        for (int[] q : qs) {
            int query = q[0];
            int idx = q[1];
            while (j < intervals.length && intervals[j][0] <= query) {
                pq.offer(intervals[j]);
                j++;
            }
            while (!pq.isEmpty() && pq.peek()[1] < query) {
                pq.poll();
            }
            res[idx] = pq.isEmpty() ? -1 : pq.peek()[1] - pq.peek()[0] + 1;
        }
        return res;
    }
}
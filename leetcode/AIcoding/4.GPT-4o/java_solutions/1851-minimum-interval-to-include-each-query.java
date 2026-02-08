import java.util.*;

class Solution {
    public int[] minInterval(int[][] intervals, int[] queries) {
        int n = queries.length;
        int[] result = new int[n];
        int[][] queriesWithIndex = new int[n][2];

        for (int i = 0; i < n; i++) {
            queriesWithIndex[i][0] = queries[i];
            queriesWithIndex[i][1] = i;
        }

        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));
        Arrays.sort(queriesWithIndex, Comparator.comparingInt(a -> a[0]));

        PriorityQueue<int[]> minHeap = new PriorityQueue<>(Comparator.comparingInt(a -> a[1] - a[0]));
        int j = 0;

        for (int i = 0; i < n; i++) {
            while (j < intervals.length && intervals[j][0] <= queriesWithIndex[i][0]) {
                minHeap.offer(intervals[j++]);
            }
            while (!minHeap.isEmpty() && minHeap.peek()[1] < queriesWithIndex[i][0]) {
                minHeap.poll();
            }
            result[queriesWithIndex[i][1]] = minHeap.isEmpty() ? -1 : minHeap.peek()[1] - minHeap.peek()[0] + 1;
        }

        return result;
    }
}
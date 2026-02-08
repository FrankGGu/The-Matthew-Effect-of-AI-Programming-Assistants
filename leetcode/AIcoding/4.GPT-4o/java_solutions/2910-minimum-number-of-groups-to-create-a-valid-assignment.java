import java.util.*;

public class Solution {
    public int minGroups(int[][] intervals) {
        Arrays.sort(intervals, Comparator.comparingInt(a -> a[0]));
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        int groups = 0;

        for (int[] interval : intervals) {
            while (!pq.isEmpty() && pq.peek() < interval[0]) {
                pq.poll();
            }
            pq.offer(interval[1]);
            groups = Math.max(groups, pq.size());
        }

        return groups;
    }
}
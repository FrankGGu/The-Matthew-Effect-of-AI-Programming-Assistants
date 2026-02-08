import java.util.*;

public class Solution {
    public int[] smallestRange(List<List<Integer>> nums) {
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));
        int max = Integer.MIN_VALUE;
        int rangeStart = 0, rangeEnd = Integer.MAX_VALUE;

        for (int i = 0; i < nums.size(); i++) {
            pq.offer(new int[]{nums.get(i).get(0), i, 0});
            max = Math.max(max, nums.get(i).get(0));
        }

        while (pq.size() == nums.size()) {
            int[] curr = pq.poll();
            int min = curr[0];
            if (rangeEnd - rangeStart > max - min) {
                rangeStart = min;
                rangeEnd = max;
            }
            if (curr[2] + 1 < nums.get(curr[1]).size()) {
                pq.offer(new int[]{nums.get(curr[1]).get(curr[2] + 1), curr[1], curr[2] + 1});
                max = Math.max(max, nums.get(curr[1]).get(curr[2] + 1));
            }
        }
        return new int[]{rangeStart, rangeEnd};
    }
}
import java.util.*;

class Solution {
    public int[] smallestRange(List<List<Integer>> nums) {
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> nums.get(a[0]).get(a[1])));
        int max = Integer.MIN_VALUE;
        for (int i = 0; i < nums.size(); i++) {
            pq.offer(new int[]{i, 0});
            max = Math.max(max, nums.get(i).get(0));
        }

        int range = Integer.MAX_VALUE;
        int start = -1, end = -1;

        while (pq.size() == nums.size()) {
            int[] curr = pq.poll();
            int row = curr[0], col = curr[1];
            int val = nums.get(row).get(col);

            if (max - val < range) {
                range = max - val;
                start = val;
                end = max;
            }

            if (col + 1 < nums.get(row).size()) {
                pq.offer(new int[]{row, col + 1});
                max = Math.max(max, nums.get(row).get(col + 1));
            }
        }

        return new int[]{start, end};
    }
}
public class Solution {

import java.util.*;

public class Solution {
    public int findScore(int[] nums) {
        int n = nums.length;
        boolean[] marked = new boolean[n];
        PriorityQueue<int[]> pq = new PriorityQueue<>(Comparator.comparingInt(a -> a[0]));

        for (int i = 0; i < n; i++) {
            pq.offer(new int[]{nums[i], i});
        }

        int score = 0;

        while (!pq.isEmpty()) {
            int[] curr = pq.poll();
            int val = curr[0];
            int index = curr[1];

            if (marked[index]) {
                continue;
            }

            score += val;

            if (index - 1 >= 0) {
                marked[index - 1] = true;
            }
            if (index + 1 < n) {
                marked[index + 1] = true;
            }
        }

        return score;
    }
}
}
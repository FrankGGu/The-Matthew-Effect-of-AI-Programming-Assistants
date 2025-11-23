public class Solution {

import java.util.*;

public class Solution {
    public int[] getFinalState(int[] nums, int k, int multiplier) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);

        for (int i = 0; i < nums.length; i++) {
            pq.offer(new int[]{nums[i], i});
        }

        while (k-- > 0 && !pq.isEmpty()) {
            int[] min = pq.poll();
            min[0] *= multiplier;
            pq.offer(min);
        }

        int[] result = new int[nums.length];
        while (!pq.isEmpty()) {
            int[] val = pq.poll();
            result[val[1]] = val[0];
        }

        return result;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public int maxDistinctElements(int[] nums) {
        Map<Integer, Integer> freq = new HashMap<>();
        for (int num : nums) {
            freq.put(num, freq.getOrDefault(num, 0) + 1);
        }

        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[1] - a[1]);
        for (Map.Entry<Integer, Integer> entry : freq.entrySet()) {
            pq.offer(new int[]{entry.getKey(), entry.getValue()});
        }

        int result = 0;
        while (!pq.isEmpty()) {
            int[] current = pq.poll();
            int num = current[0];
            int count = current[1];

            if (count == 1) {
                result++;
            } else {
                result++;
                if (count - 1 > 1) {
                    pq.offer(new int[]{num, count - 1});
                }
            }
        }

        return result;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public long minSum(int[] nums, int k) {
        PriorityQueue<Long> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.add((long) num);
        }

        while (k-- > 0) {
            long smallest = minHeap.poll();
            minHeap.add(smallest * 2);
        }

        long sum = 0;
        while (!minHeap.isEmpty()) {
            sum += minHeap.poll();
        }

        return sum;
    }
}
}
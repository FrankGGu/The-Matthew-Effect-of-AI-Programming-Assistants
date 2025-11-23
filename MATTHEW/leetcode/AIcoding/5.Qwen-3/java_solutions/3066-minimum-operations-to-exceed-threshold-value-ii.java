public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.add(num);
        }

        int operations = 0;
        while (minHeap.peek() < k) {
            int a = minHeap.poll();
            int b = minHeap.poll();
            int merged = a + b;
            minHeap.add(merged);
            operations++;
        }

        return operations;
    }
}
}
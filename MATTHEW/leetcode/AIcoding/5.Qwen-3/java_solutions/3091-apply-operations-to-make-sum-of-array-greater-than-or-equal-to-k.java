public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums, int k) {
        PriorityQueue<Integer> pq = new PriorityQueue<>();
        for (int num : nums) {
            pq.add(num);
        }
        int operations = 0;
        while (pq.peek() < k) {
            int x = pq.poll();
            int y = pq.poll();
            int merged = x + y;
            pq.add(merged);
            operations++;
        }
        return operations;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public int maximumProduct(int[] nums, int k) {
        PriorityQueue<Integer> minHeap = new PriorityQueue<>();
        for (int num : nums) {
            minHeap.add(num);
        }

        while (k-- > 0) {
            int smallest = minHeap.poll();
            minHeap.add(smallest + 1);
        }

        long result = 1;
        while (!minHeap.isEmpty()) {
            result = (result * minHeap.poll()) % (1000000007);
        }

        return (int) result;
    }
}
}
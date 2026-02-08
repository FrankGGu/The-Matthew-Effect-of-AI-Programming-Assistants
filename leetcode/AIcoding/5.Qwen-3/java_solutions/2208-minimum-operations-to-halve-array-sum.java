public class Solution {

import java.util.*;

public class Solution {
    public int minOperations(int[] nums) {
        PriorityQueue<Double> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        double sum = 0;
        for (int num : nums) {
            sum += num;
            maxHeap.add((double) num);
        }

        int operations = 0;
        double target = sum / 2;

        while (sum > target) {
            double current = maxHeap.poll();
            current /= 2;
            sum -= current;
            maxHeap.add(current);
            operations++;
        }

        return operations;
    }
}
}
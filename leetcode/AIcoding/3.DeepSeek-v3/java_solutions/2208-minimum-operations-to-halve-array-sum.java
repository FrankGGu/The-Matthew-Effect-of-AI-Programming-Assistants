import java.util.PriorityQueue;
import java.util.Collections;

class Solution {
    public int halveArray(int[] nums) {
        PriorityQueue<Double> maxHeap = new PriorityQueue<>(Collections.reverseOrder());
        double sum = 0;
        for (int num : nums) {
            maxHeap.offer((double) num);
            sum += num;
        }
        double target = sum / 2;
        int operations = 0;
        double reduced = 0;
        while (reduced < target) {
            double max = maxHeap.poll();
            double half = max / 2;
            reduced += half;
            maxHeap.offer(half);
            operations++;
        }
        return operations;
    }
}
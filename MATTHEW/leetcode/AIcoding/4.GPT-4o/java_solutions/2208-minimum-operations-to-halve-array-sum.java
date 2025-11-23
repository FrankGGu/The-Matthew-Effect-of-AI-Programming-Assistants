import java.util.PriorityQueue;

class Solution {
    public int halvingSum(int[] nums) {
        double total = 0;
        for (int num : nums) {
            total += num;
        }

        PriorityQueue<Double> maxHeap = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        for (int num : nums) {
            maxHeap.offer((double) num);
        }

        int operations = 0;
        while (total > total / 2) {
            double largest = maxHeap.poll();
            total -= largest / 2;
            maxHeap.offer(largest / 2);
            operations++;
        }

        return operations;
    }
}
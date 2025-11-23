import java.util.PriorityQueue;

class Solution {
    public int halveArray(int[] nums) {
        PriorityQueue<Double> pq = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        double currentSum = 0;
        for (int num : nums) {
            pq.offer((double) num);
            currentSum += num;
        }

        double targetSum = currentSum / 2;
        int operations = 0;

        while (currentSum > targetSum) {
            operations++;
            double maxVal = pq.poll();
            currentSum -= maxVal / 2;
            pq.offer(maxVal / 2);
        }

        return operations;
    }
}
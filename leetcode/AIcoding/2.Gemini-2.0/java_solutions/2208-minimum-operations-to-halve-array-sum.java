import java.util.PriorityQueue;

class Solution {
    public int halveArray(int[] nums) {
        PriorityQueue<Double> pq = new PriorityQueue<>((a, b) -> Double.compare(b, a));
        double sum = 0;
        for (int num : nums) {
            pq.offer((double) num);
            sum += num;
        }

        int operations = 0;
        double halvedSum = 0;
        while (halvedSum < sum / 2.0) {
            double top = pq.poll();
            halvedSum += top / 2.0;
            pq.offer(top / 2.0);
            operations++;
        }

        return operations;
    }
}
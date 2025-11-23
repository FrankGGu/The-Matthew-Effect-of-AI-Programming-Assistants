import java.util.PriorityQueue;

public class Solution {
    public boolean isPossible(int[] target) {
        long sum = 0;
        PriorityQueue<Long> maxHeap = new PriorityQueue<>((a, b) -> Long.compare(b, a));

        for (int num : target) {
            sum += num;
            maxHeap.offer((long) num);
        }

        while (true) {
            long max = maxHeap.poll();
            sum -= max;
            if (max == 1 || sum == 1) return true;
            if (sum <= 0 || max <= sum) return false;

            max %= sum;
            sum += max;
            maxHeap.offer(max);
        }
    }
}
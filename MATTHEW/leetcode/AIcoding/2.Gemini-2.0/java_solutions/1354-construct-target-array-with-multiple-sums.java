import java.util.PriorityQueue;

class Solution {
    public boolean isPossible(int[] target) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        long sum = 0;
        for (int num : target) {
            sum += num;
            pq.offer(num);
        }

        while (true) {
            int largest = pq.poll();
            long rest = sum - largest;
            if (largest == 1) {
                return true;
            }
            if (rest == 1) {
                return true;
            }
            if (largest <= rest || rest == 0) {
                return false;
            }

            int previous = (int) (largest % rest);
            if (previous == 0) {
                return false;
            }

            pq.offer(previous);
            sum = rest + previous;
        }
    }
}
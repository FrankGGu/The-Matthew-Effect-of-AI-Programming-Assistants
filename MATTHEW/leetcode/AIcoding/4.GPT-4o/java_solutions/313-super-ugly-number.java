import java.util.PriorityQueue;

public class Solution {
    public int nthSuperUglyNumber(int n, int[] primes) {
        PriorityQueue<Long> pq = new PriorityQueue<>();
        long[] uglyNumbers = new long[n];
        uglyNumbers[0] = 1;
        pq.add(1L);
        int[] indices = new int[primes.length];

        for (int i = 1; i < n; i++) {
            long nextUgly = pq.poll();
            uglyNumbers[i] = nextUgly;

            for (int j = 0; j < primes.length; j++) {
                if (nextUgly == primes[j] * uglyNumbers[indices[j]]) {
                    indices[j]++;
                }
                pq.add(primes[j] * uglyNumbers[indices[j]]);
            }

            while (!pq.isEmpty() && pq.peek() == nextUgly) {
                pq.poll();
            }
        }

        return (int) uglyNumbers[n - 1];
    }
}
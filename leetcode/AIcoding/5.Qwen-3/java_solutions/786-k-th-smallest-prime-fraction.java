public class Solution {

import java.util.PriorityQueue;

public class KthSmallestPrimeFraction {
    public int[] kthSmallestPrimeFraction(int[] A, int K) {
        PriorityQueue<double[]> pq = new PriorityQueue<>((a, b) -> Double.compare(a[0] / a[1], b[0] / b[1]));

        for (int i = 0; i < A.length; i++) {
            pq.offer(new double[]{A[i], A[A.length - 1], i, A.length - 1});
        }

        while (K-- > 1) {
            double[] frac = pq.poll();
            int i = (int) frac[2];
            int j = (int) frac[3];

            if (j - 1 >= i) {
                pq.offer(new double[]{A[i], A[j - 1], i, j - 1});
            }
        }

        double[] result = pq.poll();
        return new int[]{(int) result[0], (int) result[1]};
    }
}
}
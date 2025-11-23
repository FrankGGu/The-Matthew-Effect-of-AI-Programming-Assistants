import java.util.*;

public class Solution {
    public int[] kthSmallestPrimeFraction(int[] A, int K) {
        int n = A.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> A[b[0]] * A[a[1]] - A[a[0]] * A[b[1]]);
        for (int i = 1; i < n; i++) {
            pq.offer(new int[]{i - 1, i});
        }
        for (int i = 1; i < K; i++) {
            int[] fraction = pq.poll();
            if (fraction[0] + 1 < fraction[1]) {
                pq.offer(new int[]{fraction[0] + 1, fraction[1]});
            }
        }
        int[] res = pq.poll();
        return new int[]{A[res[0]], A[res[1]]};
    }
}
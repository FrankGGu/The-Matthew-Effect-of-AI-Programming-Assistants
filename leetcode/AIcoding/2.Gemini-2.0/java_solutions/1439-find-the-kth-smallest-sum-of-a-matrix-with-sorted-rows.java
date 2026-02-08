import java.util.PriorityQueue;
import java.util.List;
import java.util.ArrayList;

class Solution {
    public int kthSmallest(int[][] mat, int k) {
        int m = mat.length;
        int n = mat[0].length;

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        pq.offer(0);

        for (int i = 0; i < m; i++) {
            PriorityQueue<Integer> nextPq = new PriorityQueue<>((a, b) -> b - a);
            for (int sum : pq) {
                for (int j = 0; j < n; j++) {
                    int newSum = sum + mat[i][j];
                    if (nextPq.size() < k) {
                        nextPq.offer(newSum);
                    } else if (newSum < nextPq.peek()) {
                        nextPq.poll();
                        nextPq.offer(newSum);
                    }
                }
            }
            pq = nextPq;
        }

        return pq.peek();
    }
}
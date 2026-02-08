import java.util.PriorityQueue;

public class Solution {
    public int[][] kClosest(int[][] points, int K) {
        PriorityQueue<int[]> maxHeap = new PriorityQueue<>((a, b) -> {
            return Integer.compare(b[0] * b[0] + b[1] * b[1], a[0] * a[0] + a[1] * a[1]);
        });

        for (int[] point : points) {
            maxHeap.offer(point);
            if (maxHeap.size() > K) {
                maxHeap.poll();
            }
        }

        int[][] result = new int[K][2];
        for (int i = 0; i < K; i++) {
            result[i] = maxHeap.poll();
        }

        return result;
    }
}
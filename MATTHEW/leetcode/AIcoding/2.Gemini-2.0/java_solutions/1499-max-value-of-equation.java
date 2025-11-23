import java.util.PriorityQueue;

class Solution {
    public int findMaxValueOfEquation(int[][] points, int k) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);
        int maxVal = Integer.MIN_VALUE;
        for (int[] point : points) {
            int x = point[0];
            int y = point[1];
            while (!pq.isEmpty() && x - pq.peek()[1] > k) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                maxVal = Math.max(maxVal, x + y + pq.peek()[0]);
            }
            pq.offer(new int[]{y - x, x});
        }
        return maxVal;
    }
}
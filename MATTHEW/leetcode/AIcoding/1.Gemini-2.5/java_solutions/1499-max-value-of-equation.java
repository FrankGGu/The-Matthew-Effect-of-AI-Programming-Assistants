import java.util.PriorityQueue;

class Solution {
    public int findMaxValueOfEquation(int[][] points, int k) {
        long maxValue = Long.MIN_VALUE;
        // PriorityQueue stores int[] where int[0] is (y - x) and int[1] is x.
        // It's a max-heap based on (y - x) values.
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> b[0] - a[0]);

        for (int[] point : points) {
            int currentX = point[0];
            int currentY = point[1];

            // Remove points from the priority queue that are too far to the left
            // (i.e., violate the |xi - xj| <= k condition, which is xj - xi <= k for i < j)
            while (!pq.isEmpty() && currentX - pq.peek()[1] > k) {
                pq.poll();
            }

            // If there are valid points in the priority queue, calculate the equation value
            // and update the maximum.
            // The value to maximize is (yi - xi) + (yj + xj).
            // pq.peek()[0] gives yi - xi.
            // currentY + currentX gives yj + xj.
            if (!pq.isEmpty()) {
                maxValue = Math.max(maxValue, (long) currentY + currentX + pq.peek()[0]);
            }

            // Add the current point's (y - x) and x to the priority queue
            pq.offer(new int[]{currentY - currentX, currentX});
        }

        return (int) maxValue;
    }
}
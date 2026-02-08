import java.util.PriorityQueue;

class Solution {
    public int eatenApples(int[] apples, int[] days) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]); // {rotDay, count}
        int eatenApples = 0;
        int n = apples.length;
        int i = 0;

        while (i < n || !pq.isEmpty()) {
            // Add new apples
            if (i < n && apples[i] > 0) {
                pq.offer(new int[]{i + days[i], apples[i]});
            }

            // Remove rotten apples
            while (!pq.isEmpty() && pq.peek()[0] <= i) {
                pq.poll();
            }

            // Eat an apple
            if (!pq.isEmpty()) {
                int[] currentBatch = pq.peek();
                currentBatch[1]--; // Decrement count
                eatenApples++;
                if (currentBatch[1] == 0) {
                    pq.poll(); // Remove if all apples in this batch are eaten
                }
            }
            i++;
        }

        return eatenApples;
    }
}
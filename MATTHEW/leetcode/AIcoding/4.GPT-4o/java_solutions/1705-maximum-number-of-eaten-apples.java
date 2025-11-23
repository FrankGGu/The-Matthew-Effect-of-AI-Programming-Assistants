import java.util.PriorityQueue;

public class Solution {
    public int eatenApples(int[] apples, int[] days) {
        int n = apples.length;
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> a - b);
        int totalEaten = 0;

        for (int i = 0; i < n || !pq.isEmpty(); i++) {
            if (i < n && apples[i] > 0) {
                pq.offer(apples[i]);
            }
            if (!pq.isEmpty()) {
                totalEaten++;
                pq.poll();
            }
            pq.removeIf(x -> x <= 0);
        }

        return totalEaten;
    }
}
import java.util.PriorityQueue;

class Solution {
    public int eatenApples(int[] apples, int[] days) {
        int n = apples.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int eaten = 0;
        int day = 0;
        while (day < n || !pq.isEmpty()) {
            if (day < n) {
                pq.offer(new int[]{day + days[day] - 1, apples[day]});
            }
            while (!pq.isEmpty() && pq.peek()[0] < day) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                int[] curr = pq.poll();
                curr[1]--;
                eaten++;
                if (curr[1] > 0) {
                    pq.offer(new int[]{curr[0], curr[1]});
                }
            }
            day++;
        }
        return eaten;
    }
}
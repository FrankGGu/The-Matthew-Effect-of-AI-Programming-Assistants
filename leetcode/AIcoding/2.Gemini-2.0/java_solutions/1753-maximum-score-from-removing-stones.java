import java.util.PriorityQueue;

class Solution {
    public int maximumScore(int a, int b, int c) {
        PriorityQueue<Integer> pq = new PriorityQueue<>((x, y) -> y - x);
        pq.offer(a);
        pq.offer(b);
        pq.offer(c);

        int score = 0;
        while (pq.size() > 1) {
            int x = pq.poll();
            int y = pq.poll();
            score++;
            x--;
            y--;
            if (x > 0) {
                pq.offer(x);
            }
            if (y > 0) {
                pq.offer(y);
            }
        }

        return score;
    }
}
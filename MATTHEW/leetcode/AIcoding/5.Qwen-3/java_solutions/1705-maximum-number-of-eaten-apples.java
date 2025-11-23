public class Solution {

import java.util.*;

public class Solution {
    public int maxEatingApples(int[] apples, int[] days) {
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> a[0] - b[0]);
        int time = 0;
        int count = 0;
        for (int i = 0; i < apples.length || !pq.isEmpty(); i++) {
            if (i < apples.length && apples[i] > 0) {
                pq.offer(new int[]{i + days[i], apples[i]});
            }
            while (!pq.isEmpty() && pq.peek()[0] <= time) {
                pq.poll();
            }
            if (!pq.isEmpty()) {
                count++;
                pq.peek()[1]--;
                if (pq.peek()[1] == 0) {
                    pq.poll();
                }
            }
            time++;
        }
        return count;
    }
}
}
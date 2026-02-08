import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int scheduleCourse(int[][] courses) {
        Arrays.sort(courses, (a, b) -> a[1] - b[1]);

        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);

        int currentTime = 0;

        for (int[] course : courses) {
            int duration = course[0];
            int lastDay = course[1];

            currentTime += duration;
            pq.offer(duration);

            if (currentTime > lastDay) {
                if (!pq.isEmpty()) {
                    currentTime -= pq.poll();
                }
            }
        }

        return pq.size();
    }
}
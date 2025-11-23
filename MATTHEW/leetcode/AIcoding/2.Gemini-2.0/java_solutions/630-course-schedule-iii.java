import java.util.Arrays;
import java.util.PriorityQueue;

class Solution {
    public int scheduleCourse(int[][] courses) {
        Arrays.sort(courses, (a, b) -> a[1] - b[1]);
        PriorityQueue<Integer> pq = new PriorityQueue<>((a, b) -> b - a);
        int time = 0;
        for (int[] course : courses) {
            int duration = course[0];
            int deadline = course[1];
            if (time + duration <= deadline) {
                pq.offer(duration);
                time += duration;
            } else if (!pq.isEmpty() && duration < pq.peek()) {
                time -= pq.poll();
                pq.offer(duration);
                time += duration;
            }
        }
        return pq.size();
    }
}
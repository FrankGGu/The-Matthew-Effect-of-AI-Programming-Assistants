import java.util.Arrays;
import java.util.PriorityQueue;

public class Solution {
    public int scheduleCourse(int[][] courses) {
        Arrays.sort(courses, (a, b) -> a[1] - b[1]);
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int totalTime = 0;

        for (int[] course : courses) {
            totalTime += course[0];
            maxHeap.offer(course[0]);
            if (totalTime > course[1]) {
                totalTime -= maxHeap.poll();
            }
        }

        return maxHeap.size();
    }
}
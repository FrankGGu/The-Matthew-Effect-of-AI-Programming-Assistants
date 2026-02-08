public class Solution {

import java.util.*;

public class Solution {
    public int scheduleCourse(int[][] courses) {
        Arrays.sort(courses, (a, b) -> a[1] - b[1]);
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>((a, b) -> b - a);
        int time = 0;
        for (int[] course : courses) {
            int duration = course[0];
            int lastDay = course[1];
            if (time + duration <= lastDay) {
                maxHeap.add(duration);
                time += duration;
            } else if (!maxHeap.isEmpty() && maxHeap.peek() > duration) {
                time -= maxHeap.poll();
                maxHeap.add(duration);
                time += duration;
            }
        }
        return maxHeap.size();
    }
}
}
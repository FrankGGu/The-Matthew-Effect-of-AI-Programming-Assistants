public class Solution {

import java.util.*;

public class Solution {
    public int[] findCrossingTimes(int[] weights) {
        int n = weights.length;
        int[] result = new int[n];

        PriorityQueue<int[]> left = new PriorityQueue<>((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);
        PriorityQueue<int[]> right = new PriorityQueue<>((a, b) -> a[0] != b[0] ? a[0] - b[0] : a[1] - b[1]);

        for (int i = 0; i < n; i++) {
            left.offer(new int[]{weights[i], i});
        }

        int time = 0;
        int peopleCrossed = 0;

        while (peopleCrossed < n) {
            while (!left.isEmpty() && left.peek()[0] <= time) {
                int[] person = left.poll();
                right.offer(person);
            }

            while (!right.isEmpty() && right.peek()[0] <= time) {
                int[] person = right.poll();
                left.offer(person);
            }

            if (!left.isEmpty() || !right.isEmpty()) {
                int nextTime = Integer.MAX_VALUE;
                if (!left.isEmpty()) {
                    nextTime = Math.min(nextTime, left.peek()[0]);
                }
                if (!right.isEmpty()) {
                    nextTime = Math.min(nextTime, right.peek()[0]);
                }

                time = nextTime;

                while (!left.isEmpty() && left.peek()[0] == time) {
                    int[] person = left.poll();
                    result[person[1]] = time;
                    peopleCrossed++;
                }

                while (!right.isEmpty() && right.peek()[0] == time) {
                    int[] person = right.poll();
                    result[person[1]] = time;
                    peopleCrossed++;
                }
            } else {
                time++;
            }
        }

        return result;
    }
}
}
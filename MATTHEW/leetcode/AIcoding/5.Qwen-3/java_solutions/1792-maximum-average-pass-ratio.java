public class Solution {

import java.util.*;

public class Solution {
    public int[] maxAveragePassRatio(int[] classes, int[] students) {
        int n = classes.length;
        PriorityQueue<int[]> pq = new PriorityQueue<>((a, b) -> {
            double diffA = (double) (a[0] + 1) / (a[1] + 1) - (double) a[0] / a[1];
            double diffB = (double) (b[0] + 1) / (b[1] + 1) - (double) b[0] / b[1];
            return Double.compare(diffB, diffA);
        });

        for (int i = 0; i < n; i++) {
            pq.offer(new int[]{classes[i], students[i]});
        }

        while (students[0] > 0) {
            int[] current = pq.poll();
            current[0]++;
            current[1]++;
            students[0]--;
            pq.offer(current);
        }

        int[] result = new int[n];
        for (int i = 0; i < n; i++) {
            result[i] = (int) Math.round((double) classes[i] / students[i]);
        }

        return result;
    }
}
}
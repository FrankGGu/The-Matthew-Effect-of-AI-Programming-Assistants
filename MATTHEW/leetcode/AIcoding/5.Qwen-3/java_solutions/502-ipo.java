public class Solution {

import java.util.*;

public class Solution {
    public int findMaximizedCapital(int k, int w, int[] profits, int[] capital) {
        int n = profits.length;
        int[][] projects = new int[n][2];

        for (int i = 0; i < n; i++) {
            projects[i][0] = profits[i];
            projects[i][1] = capital[i];
        }

        Arrays.sort(projects, (a, b) -> a[1] - b[1]);

        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        int count = 0;
        int i = 0;

        while (count < k) {
            while (i < n && projects[i][1] <= w) {
                maxHeap.add(projects[i][0]);
                i++;
            }

            if (maxHeap.isEmpty()) {
                break;
            }

            w += maxHeap.poll();
            count++;
        }

        return w;
    }
}
}
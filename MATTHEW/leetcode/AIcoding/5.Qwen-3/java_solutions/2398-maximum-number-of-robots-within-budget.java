public class Solution {

import java.util.*;

public class Solution {
    public int maximumRobots(int[] robotCost, int[] robotPower, long budget) {
        int n = robotCost.length;
        int[][] robots = new int[n][2];
        for (int i = 0; i < n; i++) {
            robots[i][0] = robotPower[i];
            robots[i][1] = robotCost[i];
        }

        Arrays.sort(robots, (a, b) -> a[0] - b[0]);

        long totalCost = 0;
        int count = 0;
        PriorityQueue<Integer> maxHeap = new PriorityQueue<>(Collections.reverseOrder());

        for (int i = 0; i < n; i++) {
            int power = robots[i][0];
            int cost = robots[i][1];

            if (totalCost + cost > budget) {
                if (maxHeap.isEmpty()) {
                    continue;
                }
                int maxCost = maxHeap.poll();
                totalCost -= maxCost;
                count--;
            }

            maxHeap.add(cost);
            totalCost += cost;
            count++;

            if (totalCost > budget) {
                maxHeap.poll();
                totalCost -= cost;
                count--;
            }
        }

        return count;
    }
}
}
public class Solution {

import java.util.*;

public class Solution {
    public int minCostToConnectAllPoints(int[][] points) {
        int n = points.length;
        boolean[] visited = new boolean[n];
        int[] minCost = new int[n];
        Arrays.fill(minCost, Integer.MAX_VALUE);
        minCost[0] = 0;
        int totalCost = 0;

        for (int i = 0; i < n; i++) {
            int minIndex = -1;
            int minVal = Integer.MAX_VALUE;
            for (int j = 0; j < n; j++) {
                if (!visited[j] && minCost[j] < minVal) {
                    minVal = minCost[j];
                    minIndex = j;
                }
            }
            if (minIndex == -1) break;
            visited[minIndex] = true;
            totalCost += minVal;
            for (int j = 0; j < n; j++) {
                if (!visited[j]) {
                    int cost = Math.abs(points[minIndex][0] - points[j][0]) + Math.abs(points[minIndex][1] - points[j][1]);
                    if (cost < minCost[j]) {
                        minCost[j] = cost;
                    }
                }
            }
        }

        return totalCost;
    }
}
}
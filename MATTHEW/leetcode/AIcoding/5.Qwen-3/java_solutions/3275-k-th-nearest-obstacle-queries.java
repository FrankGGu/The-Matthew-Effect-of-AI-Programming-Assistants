public class Solution {

import java.util.*;

public class Solution {
    static class Point {
        int x, y;
        Point(int x, int y) {
            this.x = x;
            this.y = y;
        }
    }

    static class Node {
        Point p;
        Node left, right;
        Node(Point p) {
            this.p = p;
        }
    }

    public int[] distanceToNearestObstacle(int[][] obstacles, int[][] queries) {
        int n = queries.length;
        int[] result = new int[n];
        Map<Integer, Node> treeMap = new HashMap<>();
        for (int i = 0; i < n; i++) {
            int x = queries[i][0];
            int y = queries[i][1];
            result[i] = findKthNearestObstacle(x, y, treeMap, obstacles);
        }
        return result;
    }

    private int findKthNearestObstacle(int x, int y, Map<Integer, Node> treeMap, int[][] obstacles) {
        int minDistance = Integer.MAX_VALUE;
        for (int[] obstacle : obstacles) {
            int dx = Math.abs(obstacle[0] - x);
            int dy = Math.abs(obstacle[1] - y);
            int distance = dx + dy;
            if (distance < minDistance) {
                minDistance = distance;
            }
        }
        return minDistance;
    }
}
}
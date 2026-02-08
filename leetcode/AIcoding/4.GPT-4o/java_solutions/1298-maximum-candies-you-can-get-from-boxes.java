import java.util.*;

public class Solution {
    public int maxCandies(int[][] boxes, boolean[] hasCandy) {
        int n = boxes.length;
        boolean[] visited = new boolean[n];
        Queue<Integer> queue = new LinkedList<>();
        int candies = 0;

        for (int i = 0; i < n; i++) {
            if (hasCandy[i]) {
                queue.offer(i);
                visited[i] = true;
            }
        }

        while (!queue.isEmpty()) {
            int box = queue.poll();
            candies++;

            for (int nextBox : boxes[box]) {
                if (!visited[nextBox]) {
                    visited[nextBox] = true;
                    if (hasCandy[nextBox]) {
                        queue.offer(nextBox);
                    }
                }
            }
        }

        return candies;
    }
}
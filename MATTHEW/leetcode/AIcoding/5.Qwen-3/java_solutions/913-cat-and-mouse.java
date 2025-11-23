public class Solution {

import java.util.*;

public class Solution {
    public int catMouseGame(int[][] graph) {
        int n = graph.length;
        int[][][] dp = new int[n][n][2 * n];
        int[][][] degree = new int[n][n][2 * n];
        Queue<int[]> queue = new LinkedList<>();

        for (int mouse = 0; mouse < n; mouse++) {
            for (int cat = 0; cat < n; cat++) {
                for (int turn = 0; turn < 2 * n; turn++) {
                    if (mouse == cat) {
                        dp[mouse][cat][turn] = 1;
                    } else if (mouse == 0) {
                        dp[mouse][cat][turn] = 0;
                    } else {
                        degree[mouse][cat][turn] = graph[mouse].length + graph[cat].length;
                    }
                    if (dp[mouse][cat][turn] != 0) {
                        queue.offer(new int[]{mouse, cat, turn});
                    }
                }
            }
        }

        while (!queue.isEmpty()) {
            int[] state = queue.poll();
            int mouse = state[0], cat = state[1], turn = state[2];
            int result = dp[mouse][cat][turn];

            if (turn % 2 == 0) {
                for (int prevCat : graph[cat]) {
                    int prevTurn = turn - 1;
                    if (dp[mouse][prevCat][prevTurn] == 0) {
                        dp[mouse][prevCat][prevTurn] = result;
                        queue.offer(new int[]{mouse, prevCat, prevTurn});
                    } else if (dp[mouse][prevCat][prevTurn] == 2 && result == 1) {
                        dp[mouse][prevCat][prevTurn] = 1;
                        queue.offer(new int[]{mouse, prevCat, prevTurn});
                    }
                }
            } else {
                for (int prevMouse : graph[mouse]) {
                    int prevTurn = turn - 1;
                    if (dp[prevMouse][cat][prevTurn] == 0) {
                        dp[prevMouse][cat][prevTurn] = result;
                        queue.offer(new int[]{prevMouse, cat, prevTurn});
                    } else if (dp[prevMouse][cat][prevTurn] == 2 && result == 1) {
                        dp[prevMouse][cat][prevTurn] = 1;
                        queue.offer(new int[]{prevMouse, cat, prevTurn});
                    }
                }
            }
        }

        return dp[1][2][0];
    }
}
}
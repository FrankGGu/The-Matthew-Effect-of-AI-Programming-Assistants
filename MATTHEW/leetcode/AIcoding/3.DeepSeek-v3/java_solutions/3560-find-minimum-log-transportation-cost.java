import java.util.*;

class Solution {
    public int minCost(int[][] logs, int n) {
        int[] parent = new int[n + 1];
        for (int i = 1; i <= n; i++) {
            parent[i] = i;
        }

        Arrays.sort(logs, (a, b) -> a[2] - b[2]);

        int cost = 0;
        int count = 0;

        for (int[] log : logs) {
            int x = find(parent, log[0]);
            int y = find(parent, log[1]);
            if (x != y) {
                parent[x] = y;
                cost += log[2];
                count++;
                if (count == n - 1) {
                    break;
                }
            }
        }

        return count == n - 1 ? cost : -1;
    }

    private int find(int[] parent, int x) {
        if (parent[x] != x) {
            parent[x] = find(parent, parent[x]);
        }
        return parent[x];
    }
}
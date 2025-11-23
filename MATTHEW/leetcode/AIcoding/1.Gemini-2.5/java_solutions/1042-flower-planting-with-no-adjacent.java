import java.util.ArrayList;
import java.util.List;

class Solution {
    public int[] gardenNoAdj(int n, int[][] paths) {
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }

        for (int[] path : paths) {
            int u = path[0] - 1;
            int v = path[1] - 1;
            adj.get(u).add(v);
            adj.get(v).add(u);
        }

        int[] ans = new int[n];

        for (int i = 0; i < n; i++) {
            boolean[] usedColors = new boolean[5]; // Colors are 1-4, so index 0 is unused.

            for (int neighbor : adj.get(i)) {
                if (ans[neighbor] != 0) { // If neighbor already has a flower type
                    usedColors[ans[neighbor]] = true;
                }
            }

            for (int color = 1; color <= 4; color++) {
                if (!usedColors[color]) {
                    ans[i] = color;
                    break;
                }
            }
        }

        return ans;
    }
}
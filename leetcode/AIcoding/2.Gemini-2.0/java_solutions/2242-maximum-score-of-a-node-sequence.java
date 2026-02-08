import java.util.*;

class Solution {
    public int maximumScore(int[] scores, int[][] edges) {
        int n = scores.length;
        List<PriorityQueue<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new PriorityQueue<>((a, b) -> scores[a] - scores[b]));
        }

        for (int[] edge : edges) {
            int u = edge[0];
            int v = edge[1];
            adj.get(u).offer(v);
            adj.get(v).offer(u);

            if (adj.get(u).size() > 3) {
                adj.get(u).poll();
            }
            if (adj.get(v).size() > 3) {
                adj.get(v).poll();
            }
        }

        int ans = -1;
        for (int[] edge : edges) {
            int a = edge[0];
            int b = edge[1];

            for (int c : adj.get(a)) {
                if (c == b) continue;
                for (int d : adj.get(b)) {
                    if (d == a || d == c) continue;
                    ans = Math.max(ans, scores[a] + scores[b] + scores[c] + scores[d]);
                }
            }
        }

        return ans;
    }
}
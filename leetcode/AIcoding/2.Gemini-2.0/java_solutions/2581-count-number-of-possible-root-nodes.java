import java.util.*;

class Solution {
    public int rootCount(int[][] edges, int[][] guesses, int k) {
        int n = edges.length + 1;
        List<List<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        Set<Long> guessSet = new HashSet<>();
        for (int[] guess : guesses) {
            guessSet.add(((long) guess[0] << 32) | guess[1]);
        }

        int correctGuesses = 0;
        int[] correct = new int[1];

        dfs(0, -1, adj, guessSet, correct);
        correctGuesses = correct[0];

        int ans = 0;
        if (correctGuesses >= k) {
            ans++;
        }

        Queue<Integer> queue = new LinkedList<>();
        queue.offer(0);
        boolean[] visited = new boolean[n];
        visited[0] = true;

        while (!queue.isEmpty()) {
            int u = queue.poll();
            for (int v : adj.get(u)) {
                if (!visited[v]) {
                    int curCorrect = correctGuesses;
                    if (guessSet.contains(((long) u << 32) | v)) {
                        curCorrect--;
                    }
                    if (guessSet.contains(((long) v << 32) | u)) {
                        curCorrect++;
                    }
                    if (curCorrect >= k) {
                        ans++;
                    }
                    correctGuesses = curCorrect;
                    queue.offer(v);
                    visited[v] = true;
                }
            }
        }

        return ans;
    }

    private void dfs(int u, int parent, List<List<Integer>> adj, Set<Long> guessSet, int[] correct) {
        for (int v : adj.get(u)) {
            if (v != parent) {
                if (guessSet.contains(((long) u << 32) | v)) {
                    correct[0]++;
                }
                dfs(v, u, adj, guessSet, correct);
            }
        }
    }
}
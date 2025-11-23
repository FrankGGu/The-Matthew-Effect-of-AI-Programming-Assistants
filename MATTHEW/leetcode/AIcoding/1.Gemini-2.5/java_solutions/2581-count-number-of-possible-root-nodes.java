import java.util.*;

class Solution {
    List<List<Integer>> adj;
    Set<Long> guessSet;
    int n;
    int k;
    int initialCorrectGuessesForRoot0; // Stores the total correct guesses if node 0 is the root
    int[] ans; // ans[u] stores the total number of correct guesses if u is the root of the entire tree

    // DFS1: Calculate initial correct guesses assuming root is 0.
    // This function traverses the tree rooted at 'u' (with 'p' as its parent)
    // and increments 'initialCorrectGuessesForRoot0' for every guess (u, v)
    // where u is an ancestor of v (or u=0).
    private void dfs1(int u, int p) {
        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }
            // If (u, v) is a guess, and u is parent of v (in the tree rooted at 0),
            // it's a correct guess for the initial configuration.
            if (guessSet.contains((long) u * n + v)) {
                initialCorrectGuessesForRoot0++;
            }
            dfs1(v, u);
        }
    }

    // DFS2: Re-rooting DP to calculate correct guesses for each node as root.
    // 'currentCorrect' is the number of correct guesses if 'u' is the root of the entire tree.
    private void dfs2(int u, int p, int currentCorrect) {
        ans[u] = currentCorrect;

        for (int v : adj.get(u)) {
            if (v == p) {
                continue;
            }

            int newCorrect = currentCorrect;
            // When moving the root from u to v:
            // 1. The relationship (u, v) changes: u is no longer parent of v.
            //    If (u, v) was a guess, it becomes incorrect. Decrement.
            if (guessSet.contains((long) u * n + v)) {
                newCorrect--;
            }
            // 2. The relationship (v, u) changes: v becomes parent of u.
            //    If (v, u) is a guess, it becomes correct. Increment.
            if (guessSet.contains((long) v * n + u)) {
                newCorrect++;
            }
            dfs2(v, u, newCorrect);
        }
    }

    public int rootCount(int N, int[][] edges, int[][] guesses, int K) {
        this.n = N;
        this.k = K;

        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        guessSet = new HashSet<>();
        for (int[] guess : guesses) {
            guessSet.add((long) guess[0] * n + guess[1]);
        }

        initialCorrectGuessesForRoot0 = 0;
        ans = new int[n];

        // First DFS to calculate the total correct guesses if node 0 is the root.
        dfs1(0, -1);

        // Second DFS for re-rooting DP, starting with the count for root 0.
        dfs2(0, -1, initialCorrectGuessesForRoot0);

        int count = 0;
        for (int i = 0; i < n; i++) {
            if (ans[i] >= k) {
                count++;
            }
        }
        return count;
    }
}
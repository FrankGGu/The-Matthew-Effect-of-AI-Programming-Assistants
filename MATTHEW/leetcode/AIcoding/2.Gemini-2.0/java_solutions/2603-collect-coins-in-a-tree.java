import java.util.*;

class Solution {
    public int collectCoins(int[] coins, int[][] edges) {
        int n = coins.length;
        List<Set<Integer>> adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new HashSet<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        int remainingNodes = n;
        List<Integer> leavesToRemove = new ArrayList<>();

        for (int i = 0; i < n; i++) {
            if (adj.get(i).size() <= 1 && coins[i] == 0) {
                leavesToRemove.add(i);
            }
        }

        while (!leavesToRemove.isEmpty()) {
            List<Integer> newLeavesToRemove = new ArrayList<>();
            for (int leaf : leavesToRemove) {
                if (adj.get(leaf).size() > 0) {
                    int neighbor = adj.get(leaf).iterator().next();
                    adj.get(neighbor).remove(leaf);
                    if (adj.get(neighbor).size() <= 1 && coins[neighbor] == 0) {
                        newLeavesToRemove.add(neighbor);
                    }
                }
                adj.get(leaf).clear();
                remainingNodes--;
            }
            leavesToRemove = newLeavesToRemove;
        }

        leavesToRemove.clear();
        for (int i = 0; i < n; i++) {
            if (adj.get(i).size() <= 1 && !adj.get(i).isEmpty()) {
                leavesToRemove.add(i);
            }
        }

        for (int i = 0; i < 2; i++) {
            List<Integer> newLeavesToRemove = new ArrayList<>();
            for (int leaf : leavesToRemove) {
                if (adj.get(leaf).size() > 0) {
                    int neighbor = adj.get(leaf).iterator().next();
                    adj.get(neighbor).remove(leaf);
                    if (adj.get(neighbor).size() <= 1) {
                        newLeavesToRemove.add(neighbor);
                    }
                }
                adj.get(leaf).clear();
                remainingNodes--;
            }
            leavesToRemove = newLeavesToRemove;
        }

        if (remainingNodes <= 0) {
            return 0;
        }

        int edgesRemaining = 0;
        for (int i = 0; i < n; i++) {
            edgesRemaining += adj.get(i).size();
        }

        return edgesRemaining / 2 * 2;
    }
}
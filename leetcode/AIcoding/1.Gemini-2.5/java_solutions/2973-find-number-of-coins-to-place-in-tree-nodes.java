import java.util.*;
import java.math.BigInteger;

class Solution {
    List<List<Integer>> adj;
    long[] costs;
    long[] ans;

    public long[] findNumberOfCoins(int n, int[][] edges, int[] cost) {
        adj = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            adj.add(new ArrayList<>());
        }
        for (int[] edge : edges) {
            adj.get(edge[0]).add(edge[1]);
            adj.get(edge[1]).add(edge[0]);
        }

        this.costs = new long[n];
        for (int i = 0; i < n; i++) {
            this.costs[i] = cost[i];
        }
        ans = new long[n];

        dfs(0, -1);

        return ans;
    }

    private List<Long> dfs(int u, int parent) {
        List<Long> currentSubtreeCosts = new ArrayList<>();
        currentSubtreeCosts.add(costs[u]);

        for (int v : adj.get(u)) {
            if (v == parent) {
                continue;
            }
            List<Long> childCosts = dfs(v, u);
            currentSubtreeCosts.addAll(childCosts);
        }

        Collections.sort(currentSubtreeCosts);

        if (currentSubtreeCosts.size() > 5) {
            List<Long> trimmedList = new ArrayList<>();
            trimmedList.add(currentSubtreeCosts.get(0));
            trimmedList.add(currentSubtreeCosts.get(1));
            trimmedList.add(currentSubtreeCosts.get(currentSubtreeCosts.size() - 3));
            trimmedList.add(currentSubtreeCosts.get(currentSubtreeCosts.size() - 2));
            trimmedList.add(currentSubtreeCosts.get(currentSubtreeCosts.size() - 1));
            currentSubtreeCosts = trimmedList;
        }

        if (currentSubtreeCosts.size() < 3) {
            ans[u] = 1;
        } else {
            BigInteger p1 = BigInteger.valueOf(currentSubtreeCosts.get(currentSubtreeCosts.size() - 1))
                                .multiply(BigInteger.valueOf(currentSubtreeCosts.get(currentSubtreeCosts.size() - 2)))
                                .multiply(BigInteger.valueOf(currentSubtreeCosts.get(currentSubtreeCosts.size() - 3)));

            BigInteger p2 = BigInteger.valueOf(currentSubtreeCosts.get(0))
                    .multiply(BigInteger.valueOf(currentSubtreeCosts.get(1)))
                    .multiply(BigInteger.valueOf(currentSubtreeCosts.get(currentSubtreeCosts.size() - 1)));

            BigInteger maxProduct = p1.max(p2);

            if (maxProduct.signum() < 0) {
                ans[u] = 0;
            } else {
                if (maxProduct.compareTo(BigInteger.valueOf(Long.MAX_VALUE)) > 0) {
                    ans[u] = Long.MAX_VALUE;
                } else {
                    ans[u] = maxProduct.longValue();
                }
            }
        }

        return currentSubtreeCosts;
    }
}
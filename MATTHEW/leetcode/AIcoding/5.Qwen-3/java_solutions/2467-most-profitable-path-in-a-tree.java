public class Solution {

import java.util.*;

public class Solution {
    public int mostProfitablePath(TreeNode root, int[] customer) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        buildGraph(root, null, graph);

        int[] profit = new int[1];
        dfs(root, -1, 0, graph, customer, profit);
        return profit[0];
    }

    private void buildGraph(TreeNode node, TreeNode parent, Map<Integer, List<Integer>> graph) {
        if (node == null) return;
        if (!graph.containsKey(node.val)) {
            graph.put(node.val, new ArrayList<>());
        }
        if (parent != null) {
            graph.get(node.val).add(parent.val);
            graph.get(parent.val).add(node.val);
        }
        buildGraph(node.left, node, graph);
        buildGraph(node.right, node, graph);
    }

    private int dfs(TreeNode node, int parent, int currentProfit, Map<Integer, List<Integer>> graph, int[] customer, int[] maxProfit) {
        if (node == null) return 0;

        if (customer[node.val] != 0) {
            currentProfit += customer[node.val];
        }

        int max = currentProfit;
        for (int neighbor : graph.get(node.val)) {
            if (neighbor != parent) {
                int res = dfs(new TreeNode(neighbor), node.val, currentProfit, graph, customer, maxProfit);
                max = Math.max(max, res);
            }
        }

        maxProfit[0] = Math.max(maxProfit[0], max);
        return max;
    }
}
}
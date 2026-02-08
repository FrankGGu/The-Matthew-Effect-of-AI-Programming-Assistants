public class Solution {

import java.util.*;

public class Solution {
    int[] values;
    List<List<Integer>> graph;
    int n;
    int result;

    public int maxScore(TreeNode root, int[] nums) {
        values = nums;
        n = nums.length;
        graph = new ArrayList<>();
        for (int i = 0; i < n; i++) {
            graph.add(new ArrayList<>());
        }
        buildGraph(root, -1);
        result = 0;
        dfs(0, -1);
        return result;
    }

    private void buildGraph(TreeNode node, int parent) {
        if (node == null) return;
        if (parent != -1) {
            graph.get(node.val).add(parent);
            graph.get(parent).add(node.val);
        }
        buildGraph(node.left, node.val);
        buildGraph(node.right, node.val);
    }

    private int dfs(int node, int parent) {
        int sum = values[node];
        for (int neighbor : graph.get(node)) {
            if (neighbor != parent) {
                int childSum = dfs(neighbor, node);
                sum += childSum;
            }
        }
        if (parent != -1) {
            result = Math.max(result, (sum) * (values[0] - sum));
        }
        return sum;
    }
}
}
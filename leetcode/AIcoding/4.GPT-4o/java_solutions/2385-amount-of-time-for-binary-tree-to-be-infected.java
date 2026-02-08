import java.util.*;

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public int amountOfTime(TreeNode root, int start) {
        Map<TreeNode, List<TreeNode>> graph = new HashMap<>();
        buildGraph(root, null, graph);

        Queue<TreeNode> queue = new LinkedList<>();
        Set<TreeNode> visited = new HashSet<>();

        TreeNode startNode = findStartNode(root, start);
        queue.add(startNode);
        visited.add(startNode);

        int time = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                for (TreeNode neighbor : graph.get(node)) {
                    if (!visited.contains(neighbor)) {
                        visited.add(neighbor);
                        queue.add(neighbor);
                    }
                }
            }
            if (!queue.isEmpty()) time++;
        }

        return time;
    }

    private void buildGraph(TreeNode node, TreeNode parent, Map<TreeNode, List<TreeNode>> graph) {
        if (node == null) return;
        if (!graph.containsKey(node)) graph.put(node, new ArrayList<>());
        if (parent != null) {
            graph.get(node).add(parent);
            graph.get(parent).add(node);
        }
        buildGraph(node.left, node, graph);
        buildGraph(node.right, node, graph);
    }

    private TreeNode findStartNode(TreeNode node, int start) {
        if (node == null) return null;
        if (node.val == start) return node;
        TreeNode left = findStartNode(node.left, start);
        if (left != null) return left;
        return findStartNode(node.right, start);
    }
}
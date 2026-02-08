import java.util.*;

class Solution {
    public List<Integer> distanceK(TreeNode root, TreeNode target, int K) {
        Map<TreeNode, List<TreeNode>> graph = new HashMap<>();
        buildGraph(root, null, graph);
        List<Integer> result = new ArrayList<>();
        Queue<TreeNode> queue = new LinkedList<>();
        Set<TreeNode> visited = new HashSet<>();

        queue.offer(target);
        visited.add(target);
        int distance = 0;

        while (!queue.isEmpty()) {
            if (distance == K) {
                for (TreeNode node : queue) {
                    result.add(node.val);
                }
                return result;
            }
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode current = queue.poll();
                for (TreeNode neighbor : graph.get(current)) {
                    if (!visited.contains(neighbor)) {
                        visited.add(neighbor);
                        queue.offer(neighbor);
                    }
                }
            }
            distance++;
        }

        return result;
    }

    private void buildGraph(TreeNode node, TreeNode parent, Map<TreeNode, List<TreeNode>> graph) {
        if (node == null) return;
        if (!graph.containsKey(node)) {
            graph.put(node, new ArrayList<>());
        }
        if (parent != null) {
            graph.get(node).add(parent);
            graph.get(parent).add(node);
        }
        buildGraph(node.left, node, graph);
        buildGraph(node.right, node, graph);
    }
}
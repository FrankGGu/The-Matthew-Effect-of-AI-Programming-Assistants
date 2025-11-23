import java.util.*;

class Solution {
    Map<Integer, List<Integer>> adj;

    public int amountOfTime(TreeNode root, int start) {
        adj = new HashMap<>();
        buildGraph(root, null);

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        int time = -1;

        queue.offer(start);
        visited.add(start);

        while (!queue.isEmpty()) {
            int levelSize = queue.size();
            time++;

            for (int i = 0; i < levelSize; i++) {
                int current = queue.poll();

                if (adj.containsKey(current)) {
                    for (int neighbor : adj.get(current)) {
                        if (!visited.contains(neighbor)) {
                            visited.add(neighbor);
                            queue.offer(neighbor);
                        }
                    }
                }
            }
        }
        return time;
    }

    private void buildGraph(TreeNode node, TreeNode parent) {
        if (node == null) {
            return;
        }

        adj.computeIfAbsent(node.val, k -> new ArrayList<>());

        if (parent != null) {
            adj.get(node.val).add(parent.val);
            adj.computeIfAbsent(parent.val, k -> new ArrayList<>()).add(node.val);
        }

        buildGraph(node.left, node);
        buildGraph(node.right, node);
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}
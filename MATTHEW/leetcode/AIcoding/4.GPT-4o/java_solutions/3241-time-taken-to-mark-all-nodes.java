class Solution {
    public int amountOfTime(TreeNode root, int start) {
        Map<TreeNode, List<TreeNode>> graph = new HashMap<>();
        buildGraph(root, null, graph);

        TreeNode startNode = findStartNode(root, start);
        return bfs(graph, startNode);
    }

    private void buildGraph(TreeNode node, TreeNode parent, Map<TreeNode, List<TreeNode>> graph) {
        if (node == null) return;
        if (parent != null) {
            graph.computeIfAbsent(parent, x -> new ArrayList<>()).add(node);
            graph.computeIfAbsent(node, x -> new ArrayList<>()).add(parent);
        }
        buildGraph(node.left, node, graph);
        buildGraph(node.right, node, graph);
    }

    private TreeNode findStartNode(TreeNode node, int start) {
        if (node == null) return null;
        if (node.val == start) return node;
        TreeNode leftResult = findStartNode(node.left, start);
        if (leftResult != null) return leftResult;
        return findStartNode(node.right, start);
    }

    private int bfs(Map<TreeNode, List<TreeNode>> graph, TreeNode startNode) {
        Queue<TreeNode> queue = new LinkedList<>();
        Set<TreeNode> visited = new HashSet<>();
        queue.offer(startNode);
        visited.add(startNode);
        int time = 0;

        while (!queue.isEmpty()) {
            int size = queue.size();
            for (int i = 0; i < size; i++) {
                TreeNode node = queue.poll();
                for (TreeNode neighbor : graph.get(node)) {
                    if (!visited.contains(neighbor)) {
                        visited.add(neighbor);
                        queue.offer(neighbor);
                    }
                }
            }
            if (!queue.isEmpty()) time++;
        }
        return time;
    }
}
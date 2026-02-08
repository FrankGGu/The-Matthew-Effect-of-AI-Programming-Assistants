class Solution {
    public int amountOfTime(TreeNode root, int start) {
        Map<Integer, List<Integer>> graph = new HashMap<>();
        buildGraph(root, graph);

        Queue<Integer> queue = new LinkedList<>();
        Set<Integer> visited = new HashSet<>();
        queue.offer(start);
        visited.add(start);
        int time = -1;

        while (!queue.isEmpty()) {
            int size = queue.size();
            time++;
            for (int i = 0; i < size; i++) {
                int current = queue.poll();
                for (int neighbor : graph.getOrDefault(current, new ArrayList<>())) {
                    if (!visited.contains(neighbor)) {
                        visited.add(neighbor);
                        queue.offer(neighbor);
                    }
                }
            }
        }
        return time;
    }

    private void buildGraph(TreeNode node, Map<Integer, List<Integer>> graph) {
        if (node == null) return;

        if (node.left != null) {
            graph.computeIfAbsent(node.val, k -> new ArrayList<>()).add(node.left.val);
            graph.computeIfAbsent(node.left.val, k -> new ArrayList<>()).add(node.val);
            buildGraph(node.left, graph);
        }

        if (node.right != null) {
            graph.computeIfAbsent(node.val, k -> new ArrayList<>()).add(node.right.val);
            graph.computeIfAbsent(node.right.val, k -> new ArrayList<>()).add(node.val);
            buildGraph(node.right, graph);
        }
    }
}
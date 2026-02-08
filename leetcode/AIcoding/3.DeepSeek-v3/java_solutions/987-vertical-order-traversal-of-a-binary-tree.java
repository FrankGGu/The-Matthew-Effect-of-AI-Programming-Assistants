class Solution {
    class NodeInfo {
        TreeNode node;
        int row;
        int col;
        NodeInfo(TreeNode node, int row, int col) {
            this.node = node;
            this.row = row;
            this.col = col;
        }
    }

    public List<List<Integer>> verticalTraversal(TreeNode root) {
        List<List<Integer>> result = new ArrayList<>();
        if (root == null) return result;

        TreeMap<Integer, TreeMap<Integer, PriorityQueue<Integer>>> map = new TreeMap<>();
        Queue<NodeInfo> queue = new LinkedList<>();
        queue.offer(new NodeInfo(root, 0, 0));

        while (!queue.isEmpty()) {
            NodeInfo current = queue.poll();
            TreeNode node = current.node;
            int row = current.row;
            int col = current.col;

            if (!map.containsKey(col)) {
                map.put(col, new TreeMap<>());
            }
            if (!map.get(col).containsKey(row)) {
                map.get(col).put(row, new PriorityQueue<>());
            }
            map.get(col).get(row).offer(node.val);

            if (node.left != null) {
                queue.offer(new NodeInfo(node.left, row + 1, col - 1));
            }
            if (node.right != null) {
                queue.offer(new NodeInfo(node.right, row + 1, col + 1));
            }
        }

        for (TreeMap<Integer, PriorityQueue<Integer>> cols : map.values()) {
            List<Integer> list = new ArrayList<>();
            for (PriorityQueue<Integer> rows : cols.values()) {
                while (!rows.isEmpty()) {
                    list.add(rows.poll());
                }
            }
            result.add(list);
        }

        return result;
    }
}
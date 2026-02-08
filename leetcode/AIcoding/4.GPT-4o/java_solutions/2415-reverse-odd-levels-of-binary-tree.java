class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    public TreeNode reverseOddLevels(TreeNode root) {
        if (root == null) return null;
        List<List<Integer>> levels = new ArrayList<>();
        traverse(root, 0, levels);

        for (int i = 1; i < levels.size(); i += 2) {
            Collections.reverse(levels.get(i));
        }

        return buildTree(levels);
    }

    private void traverse(TreeNode node, int depth, List<List<Integer>> levels) {
        if (node == null) return;
        if (levels.size() == depth) levels.add(new ArrayList<>());
        levels.get(depth).add(node.val);
        traverse(node.left, depth + 1, levels);
        traverse(node.right, depth + 1, levels);
    }

    private TreeNode buildTree(List<List<Integer>> levels) {
        return buildTreeHelper(levels, 0, 0);
    }

    private TreeNode buildTreeHelper(List<List<Integer>> levels, int depth, int index) {
        if (depth >= levels.size() || index >= levels.get(depth).size()) return null;
        TreeNode node = new TreeNode(levels.get(depth).get(index));
        node.left = buildTreeHelper(levels, depth + 1, index * 2);
        node.right = buildTreeHelper(levels, depth + 1, index * 2 + 1);
        return node;
    }
}
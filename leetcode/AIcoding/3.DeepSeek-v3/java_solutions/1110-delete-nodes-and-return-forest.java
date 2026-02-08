class Solution {
    public List<TreeNode> delNodes(TreeNode root, int[] to_delete) {
        List<TreeNode> forest = new ArrayList<>();
        Set<Integer> toDelete = new HashSet<>();
        for (int val : to_delete) {
            toDelete.add(val);
        }
        deleteNodes(root, toDelete, forest, true);
        return forest;
    }

    private TreeNode deleteNodes(TreeNode node, Set<Integer> toDelete, List<TreeNode> forest, boolean isRoot) {
        if (node == null) {
            return null;
        }
        boolean shouldDelete = toDelete.contains(node.val);
        if (isRoot && !shouldDelete) {
            forest.add(node);
        }
        node.left = deleteNodes(node.left, toDelete, forest, shouldDelete);
        node.right = deleteNodes(node.right, toDelete, forest, shouldDelete);
        return shouldDelete ? null : node;
    }
}
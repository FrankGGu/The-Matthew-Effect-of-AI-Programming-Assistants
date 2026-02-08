class Solution {
    public TreeNode canMerge(List<TreeNode> trees) {
        Map<Integer, TreeNode> valToRoot = new HashMap<>();
        Map<Integer, Integer> count = new HashMap<>();

        for (TreeNode tree : trees) {
            valToRoot.put(tree.val, tree);
            count.put(tree.val, count.getOrDefault(tree.val, 0) + 1);
            if (tree.left != null) {
                count.put(tree.left.val, count.getOrDefault(tree.left.val, 0) + 1);
            }
            if (tree.right != null) {
                count.put(tree.right.val, count.getOrDefault(tree.right.val, 0) + 1);
            }
        }

        TreeNode root = null;
        for (TreeNode tree : trees) {
            if (count.get(tree.val) == 1) {
                root = tree;
                break;
            }
        }

        if (root == null) {
            return null;
        }

        valToRoot.remove(root.val);
        boolean isValid = build(root, Integer.MIN_VALUE, Integer.MAX_VALUE, valToRoot);
        if (!isValid || !valToRoot.isEmpty()) {
            return null;
        }

        return root;
    }

    private boolean build(TreeNode node, int min, int max, Map<Integer, TreeNode> valToRoot) {
        if (node == null) {
            return true;
        }
        if (node.val <= min || node.val >= max) {
            return false;
        }
        if (node.left == null && node.right == null) {
            if (valToRoot.containsKey(node.val)) {
                TreeNode next = valToRoot.get(node.val);
                node.left = next.left;
                node.right = next.right;
                valToRoot.remove(node.val);
            }
        }
        return build(node.left, min, node.val, valToRoot) && build(node.right, node.val, max, valToRoot);
    }
}
class Solution {
    public TreeNode canMerge(List<TreeNode> trees) {
        Map<Integer, TreeNode> map = new HashMap<>();
        Map<Integer, Integer> inDegree = new HashMap<>();

        for (TreeNode tree : trees) {
            map.put(tree.val, tree);
            inDegree.put(tree.val, 0);
        }

        for (TreeNode tree : trees) {
            if (tree.left != null) {
                if (!map.containsKey(tree.left.val)) return null;
                inDegree.put(tree.left.val, inDegree.get(tree.left.val) + 1);
            }
            if (tree.right != null) {
                if (!map.containsKey(tree.right.val)) return null;
                inDegree.put(tree.right.val, inDegree.get(tree.right.val) + 1);
            }
        }

        TreeNode root = null;
        int rootCount = 0;
        for (TreeNode tree : trees) {
            if (inDegree.get(tree.val) == 0) {
                root = tree;
                rootCount++;
            }
        }

        if (rootCount != 1) return null;

        Set<Integer> visited = new HashSet<>();
        if (!isValidBST(root, null, null, map, visited)) return null;

        if (visited.size() != trees.size()) return null;

        return root;
    }

    private boolean isValidBST(TreeNode node, Integer min, Integer max, Map<Integer, TreeNode> map, Set<Integer> visited) {
        if (node == null) return true;

        if (min != null && node.val <= min) return false;
        if (max != null && node.val >= max) return false;

        if (visited.contains(node.val)) return false;
        visited.add(node.val);

        TreeNode original = map.get(node.val);
        node.left = original.left;
        node.right = original.right;

        return isValidBST(node.left, min, node.val, map, visited) && isValidBST(node.right, node.val, max, map, visited);
    }
}
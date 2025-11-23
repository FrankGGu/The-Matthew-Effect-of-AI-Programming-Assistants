class Solution {
    private String smallestString = null;

    public String smallestFromLeaf(TreeNode root) {
        if (root == null) {
            return "";
        }
        dfs(root, new StringBuilder());
        return smallestString;
    }

    private void dfs(TreeNode node, StringBuilder currentPath) {
        if (node == null) {
            return;
        }

        currentPath.insert(0, (char) ('a' + node.val));

        if (node.left == null && node.right == null) {
            String currentString = currentPath.toString();
            if (smallestString == null || currentString.compareTo(smallestString) < 0) {
                smallestString = currentString;
            }
        } else {
            dfs(node.left, currentPath);
            dfs(node.right, currentPath);
        }

        currentPath.deleteCharAt(0);
    }
}
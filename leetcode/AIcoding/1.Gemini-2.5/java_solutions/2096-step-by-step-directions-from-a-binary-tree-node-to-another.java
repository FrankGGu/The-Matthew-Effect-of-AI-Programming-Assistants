class Solution {

    private TreeNode findLCA(TreeNode root, int p, int q) {
        if (root == null || root.val == p || root.val == q) {
            return root;
        }
        TreeNode left = findLCA(root.left, p, q);
        TreeNode right = findLCA(root.right, p, q);

        if (left != null && right != null) {
            return root;
        }
        return left != null ? left : right;
    }

    private boolean findPath(TreeNode root, int targetValue, StringBuilder path) {
        if (root == null) {
            return false;
        }
        if (root.val == targetValue) {
            return true;
        }

        path.append('L');
        if (findPath(root.left, targetValue, path)) {
            return true;
        }
        path.deleteCharAt(path.length() - 1);

        path.append('R');
        if (findPath(root.right, targetValue, path)) {
            return true;
        }
        path.deleteCharAt(path.length() - 1);

        return false;
    }

    public String getDirections(TreeNode root, int startValue, int destValue) {
        TreeNode lca = findLCA(root, startValue, destValue);

        StringBuilder pathToStartSb = new StringBuilder();
        findPath(lca, startValue, pathToStartSb);

        StringBuilder pathToDestSb = new StringBuilder();
        findPath(lca, destValue, pathToDestSb);

        StringBuilder result = new StringBuilder();
        for (int i = 0; i < pathToStartSb.length(); i++) {
            result.append('U');
        }
        result.append(pathToDestSb);

        return result.toString();
    }
}
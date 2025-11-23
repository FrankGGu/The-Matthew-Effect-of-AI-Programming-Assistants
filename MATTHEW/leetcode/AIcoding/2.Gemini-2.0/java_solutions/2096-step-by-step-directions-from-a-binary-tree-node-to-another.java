class Solution {
    public String getDirections(TreeNode root, int startValue, int destValue) {
        TreeNode lca = findLCA(root, startValue, destValue);
        String startPath = getPath(lca, startValue, new StringBuilder());
        String destPath = getPath(lca, destValue, new StringBuilder());

        StringBuilder up = new StringBuilder();
        for (int i = 0; i < startPath.length(); i++) {
            up.append("U");
        }

        return up.toString() + destPath;
    }

    private TreeNode findLCA(TreeNode root, int p, int q) {
        if (root == null || root.val == p || root.val == q) {
            return root;
        }

        TreeNode left = findLCA(root.left, p, q);
        TreeNode right = findLCA(root.right, p, q);

        if (left != null && right != null) {
            return root;
        }

        return (left != null) ? left : right;
    }

    private String getPath(TreeNode root, int target, StringBuilder path) {
        if (root == null) {
            return null;
        }

        if (root.val == target) {
            return path.toString();
        }

        path.append("L");
        String leftPath = getPath(root.left, target, path);
        if (leftPath != null) {
            return leftPath;
        }
        path.deleteCharAt(path.length() - 1);

        path.append("R");
        String rightPath = getPath(root.right, target, path);
        if (rightPath != null) {
            return rightPath;
        }
        path.deleteCharAt(path.length() - 1);

        return null;
    }
}
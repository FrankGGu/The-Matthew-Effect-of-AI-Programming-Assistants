public class Solution {
    public String getDirections(TreeNode root, int startValue, int endValue) {
        StringBuilder pathToStart = new StringBuilder();
        StringBuilder pathToEnd = new StringBuilder();

        findPath(root, startValue, pathToStart);
        findPath(root, endValue, pathToEnd);

        int i = 0;
        while (i < pathToStart.length() && i < pathToEnd.length() && pathToStart.charAt(i) == pathToEnd.charAt(i)) {
            i++;
        }

        StringBuilder result = new StringBuilder();
        for (int j = i; j < pathToStart.length(); j++) {
            result.append('U');
        }
        for (int j = i; j < pathToEnd.length(); j++) {
            result.append(pathToEnd.charAt(j));
        }

        return result.toString();
    }

    private boolean findPath(TreeNode node, int target, StringBuilder path) {
        if (node == null) {
            return false;
        }
        if (node.val == target) {
            return true;
        }
        if (findPath(node.left, target, path)) {
            path.insert(0, 'L');
            return true;
        }
        if (findPath(node.right, target, path)) {
            path.insert(0, 'R');
            return true;
        }
        return false;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) { this.val = val; }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
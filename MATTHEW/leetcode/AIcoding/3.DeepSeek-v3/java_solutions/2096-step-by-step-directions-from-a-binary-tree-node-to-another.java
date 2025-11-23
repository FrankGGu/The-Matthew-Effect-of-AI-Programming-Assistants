class Solution {
    public String getDirections(TreeNode root, int startValue, int destValue) {
        StringBuilder startPath = new StringBuilder();
        StringBuilder destPath = new StringBuilder();
        findPath(root, startValue, startPath);
        findPath(root, destValue, destPath);
        startPath.reverse();
        destPath.reverse();
        int i = 0, j = 0;
        while (i < startPath.length() && j < destPath.length() && startPath.charAt(i) == destPath.charAt(j)) {
            i++;
            j++;
        }
        StringBuilder result = new StringBuilder();
        for (int k = i; k < startPath.length(); k++) {
            result.append('U');
        }
        result.append(destPath.substring(j));
        return result.toString();
    }

    private boolean findPath(TreeNode node, int target, StringBuilder path) {
        if (node == null) return false;
        if (node.val == target) return true;
        if (findPath(node.left, target, path)) {
            path.append('L');
            return true;
        }
        if (findPath(node.right, target, path)) {
            path.append('R');
            return true;
        }
        return false;
    }
}
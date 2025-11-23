public class Solution {

class Solution {
    public String smallestFromLeaf(TreeNode root) {
        StringBuilder result = new StringBuilder();
        dfs(root, new StringBuilder(), result);
        return result.toString();
    }

    private void dfs(TreeNode node, StringBuilder path, StringBuilder result) {
        if (node == null) return;
        path.append((char) ('a' + node.val));
        if (node.left == null && node.right == null) {
            String current = path.reverse().toString();
            if (result.length() == 0 || current.compareTo(result.toString()) < 0) {
                result.setLength(0);
                result.append(current);
            }
            path.reverse();
            return;
        }
        dfs(node.left, path, result);
        dfs(node.right, path, result);
        path.deleteCharAt(path.length() - 1);
    }
}
}
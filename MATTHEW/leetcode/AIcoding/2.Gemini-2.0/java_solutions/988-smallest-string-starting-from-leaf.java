class Solution {
    String smallest = null;

    public String smallestFromLeaf(TreeNode root) {
        dfs(root, new StringBuilder());
        return smallest;
    }

    private void dfs(TreeNode node, StringBuilder sb) {
        if (node == null) return;

        sb.append((char)('a' + node.val));

        if (node.left == null && node.right == null) {
            String current = sb.reverse().toString();
            if (smallest == null || current.compareTo(smallest) < 0) {
                smallest = current;
            }
            sb.reverse();
        } else {
            dfs(node.left, sb);
            dfs(node.right, sb);
        }

        sb.deleteCharAt(sb.length() - 1);
    }
}
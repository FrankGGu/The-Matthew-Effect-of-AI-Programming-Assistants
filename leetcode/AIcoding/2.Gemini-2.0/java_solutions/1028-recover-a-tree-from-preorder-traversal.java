class Solution {
    int index = 0;
    public TreeNode recoverFromPreorder(String traversal) {
        return helper(traversal, 0);
    }

    private TreeNode helper(String traversal, int depth) {
        int dashes = 0;
        int i = index;
        while (i < traversal.length() && traversal.charAt(i) == '-') {
            dashes++;
            i++;
        }

        if (dashes != depth) {
            return null;
        }

        index = i;
        int num = 0;
        while (index < traversal.length() && Character.isDigit(traversal.charAt(index))) {
            num = num * 10 + (traversal.charAt(index) - '0');
            index++;
        }

        TreeNode node = new TreeNode(num);
        node.left = helper(traversal, depth + 1);
        node.right = helper(traversal, depth + 1);

        return node;
    }
}
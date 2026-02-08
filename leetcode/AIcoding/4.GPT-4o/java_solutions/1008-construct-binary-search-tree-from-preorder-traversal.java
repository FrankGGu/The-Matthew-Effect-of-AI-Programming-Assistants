class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

class Solution {
    public TreeNode bstFromPreorder(int[] preorder) {
        return buildTree(preorder, 0, preorder.length - 1);
    }

    private TreeNode buildTree(int[] preorder, int start, int end) {
        if (start > end) return null;
        TreeNode root = new TreeNode(preorder[start]);
        int rightStart = start + 1;

        while (rightStart <= end && preorder[rightStart] < root.val) {
            rightStart++;
        }

        root.left = buildTree(preorder, start + 1, rightStart - 1);
        root.right = buildTree(preorder, rightStart, end);
        return root;
    }
}
class Solution {
    int idx;

    public TreeNode bstFromPreorder(int[] preorder) {
        idx = 0;
        return build(preorder, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    private TreeNode build(int[] preorder, int lowerBound, int upperBound) {
        if (idx == preorder.length || preorder[idx] < lowerBound || preorder[idx] > upperBound) {
            return null;
        }

        TreeNode root = new TreeNode(preorder[idx]);
        idx++;

        root.left = build(preorder, lowerBound, root.val);
        root.right = build(preorder, root.val, upperBound);

        return root;
    }
}
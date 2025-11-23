class Solution {
    private int index = 0;

    public TreeNode bstFromPreorder(int[] preorder) {
        return helper(preorder, Integer.MIN_VALUE, Integer.MAX_VALUE);
    }

    private TreeNode helper(int[] preorder, int lower, int upper) {
        if (index >= preorder.length || preorder[index] < lower || preorder[index] > upper) {
            return null;
        }
        int val = preorder[index++];
        TreeNode node = new TreeNode(val);
        node.left = helper(preorder, lower, val);
        node.right = helper(preorder, val, upper);
        return node;
    }
}
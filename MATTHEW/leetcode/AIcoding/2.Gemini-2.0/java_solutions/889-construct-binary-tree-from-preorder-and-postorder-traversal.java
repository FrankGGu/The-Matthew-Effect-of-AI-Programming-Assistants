class Solution {
    public TreeNode constructFromPrePost(int[] preorder, int[] postorder) {
        return constructFromPrePost(preorder, 0, preorder.length - 1, postorder, 0, postorder.length - 1);
    }

    private TreeNode constructFromPrePost(int[] preorder, int preStart, int preEnd, int[] postorder, int postStart, int postEnd) {
        if (preStart > preEnd) {
            return null;
        }

        TreeNode root = new TreeNode(preorder[preStart]);

        if (preStart == preEnd) {
            return root;
        }

        int leftVal = preorder[preStart + 1];
        int leftIndex = -1;

        for (int i = postStart; i <= postEnd; i++) {
            if (postorder[i] == leftVal) {
                leftIndex = i;
                break;
            }
        }

        int leftSize = leftIndex - postStart + 1;

        root.left = constructFromPrePost(preorder, preStart + 1, preStart + leftSize, postorder, postStart, leftIndex);
        root.right = constructFromPrePost(preorder, preStart + leftSize + 1, preEnd, postorder, leftIndex + 1, postEnd - 1);

        return root;
    }
}
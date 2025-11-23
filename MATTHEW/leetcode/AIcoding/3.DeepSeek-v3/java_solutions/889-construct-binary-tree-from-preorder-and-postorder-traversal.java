class Solution {
    public TreeNode constructFromPrePost(int[] pre, int[] post) {
        return helper(pre, post, 0, pre.length - 1, 0, post.length - 1);
    }

    private TreeNode helper(int[] pre, int[] post, int preStart, int preEnd, int postStart, int postEnd) {
        if (preStart > preEnd) {
            return null;
        }
        TreeNode root = new TreeNode(pre[preStart]);
        if (preStart == preEnd) {
            return root;
        }
        int leftRootVal = pre[preStart + 1];
        int leftRootPostIdx = postStart;
        while (post[leftRootPostIdx] != leftRootVal) {
            leftRootPostIdx++;
        }
        int leftSize = leftRootPostIdx - postStart + 1;
        root.left = helper(pre, post, preStart + 1, preStart + leftSize, postStart, leftRootPostIdx);
        root.right = helper(pre, post, preStart + leftSize + 1, preEnd, leftRootPostIdx + 1, postEnd - 1);
        return root;
    }
}
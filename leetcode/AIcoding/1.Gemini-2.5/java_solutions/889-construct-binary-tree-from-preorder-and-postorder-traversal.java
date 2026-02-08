import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> postorderMap;
    private int[] preorder;
    private int[] postorder;

    public TreeNode constructFromPrePost(int[] preorder, int[] postorder) {
        this.preorder = preorder;
        this.postorder = postorder;
        this.postorderMap = new HashMap<>();
        for (int i = 0; i < postorder.length; i++) {
            postorderMap.put(postorder[i], i);
        }

        return build(0, preorder.length - 1, 0, postorder.length - 1);
    }

    private TreeNode build(int preStart, int preEnd, int postStart, int postEnd) {
        if (preStart > preEnd || postStart > postEnd) {
            return null;
        }

        TreeNode root = new TreeNode(preorder[preStart]);

        if (preStart == preEnd) {
            return root;
        }

        int leftSubtreeRootVal = preorder[preStart + 1];
        int leftSubtreeRootInPostorderIdx = postorderMap.get(leftSubtreeRootVal);

        int lenLeftSubtree = leftSubtreeRootInPostorderIdx - postStart + 1;

        root.left = build(preStart + 1, preStart + lenLeftSubtree,
                          postStart, leftSubtreeRootInPostorderIdx);

        root.right = build(preStart + lenLeftSubtree + 1, preEnd,
                           leftSubtreeRootInPostorderIdx + 1, postEnd - 1);

        return root;
    }
}
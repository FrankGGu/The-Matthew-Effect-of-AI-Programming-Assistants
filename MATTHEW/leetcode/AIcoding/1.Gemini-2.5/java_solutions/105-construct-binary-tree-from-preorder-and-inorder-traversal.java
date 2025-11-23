import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> inorderValToIndex;

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        inorderValToIndex = new HashMap<>();
        for (int i = 0; i < inorder.length; i++) {
            inorderValToIndex.put(inorder[i], i);
        }

        return build(preorder, 0, preorder.length - 1, inorder, 0, inorder.length - 1);
    }

    private TreeNode build(int[] preorder, int preStart, int preEnd, int[] inorder, int inStart, int inEnd) {
        if (preStart > preEnd || inStart > inEnd) {
            return null;
        }

        int rootVal = preorder[preStart];
        TreeNode root = new TreeNode(rootVal);

        int inRootIndex = inorderValToIndex.get(rootVal);
        int numsLeft = inRootIndex - inStart;

        root.left = build(preorder, preStart + 1, preStart + numsLeft, inorder, inStart, inRootIndex - 1);
        root.right = build(preorder, preStart + numsLeft + 1, preEnd, inorder, inRootIndex + 1, inEnd);

        return root;
    }
}
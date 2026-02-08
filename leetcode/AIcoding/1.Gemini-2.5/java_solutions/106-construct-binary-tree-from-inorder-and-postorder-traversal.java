import java.util.HashMap;
import java.util.Map;

class Solution {
    private Map<Integer, Integer> inorderMap;
    private int[] postorder;

    public TreeNode buildTree(int[] inorder, int[] postorder) {
        this.postorder = postorder;
        this.inorderMap = new HashMap<>();
        for (int i = 0; i < inorder.length; i++) {
            inorderMap.put(inorder[i], i);
        }

        return build(0, inorder.length - 1, 0, postorder.length - 1);
    }

    private TreeNode build(int inStart, int inEnd, int postStart, int postEnd) {
        if (inStart > inEnd || postStart > postEnd) {
            return null;
        }

        int rootVal = postorder[postEnd];
        TreeNode root = new TreeNode(rootVal);

        int rootInIndex = inorderMap.get(rootVal);

        int numsLeft = rootInIndex - inStart;

        root.left = build(inStart, rootInIndex - 1, postStart, postStart + numsLeft - 1);
        root.right = build(rootInIndex + 1, inEnd, postStart + numsLeft, postEnd - 1);

        return root;
    }
}
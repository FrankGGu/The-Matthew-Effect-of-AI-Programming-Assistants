import java.util.HashMap;
import java.util.Map;

public class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode() {}
    TreeNode(int val) { this.val = val; }
    TreeNode(int val, TreeNode left, TreeNode right) {
        this.val = val;
        this.left = left;
        this.right = right;
    }
}

class Solution {
    private Map<Integer, Integer> inorderMap;
    private int[] preorder;

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        this.preorder = preorder;
        this.inorderMap = new HashMap<>();

        for (int i = 0; i < inorder.length; i++) {
            inorderMap.put(inorder[i], i);
        }

        return build(0, preorder.length - 1, 0, inorder.length - 1);
    }

    private TreeNode build(int preStart, int preEnd, int inStart, int inEnd) {
        if (preStart > preEnd || inStart > inEnd) {
            return null;
        }

        int rootVal = preorder[preStart];
        TreeNode root = new TreeNode(rootVal);

        int inRootIndex = inorderMap.get(rootVal);
        int numsLeft = inRootIndex - inStart;

        root.left = build(preStart + 1, preStart + numsLeft, inStart, inRootIndex - 1);
        root.right = build(preStart + numsLeft + 1, preEnd, inRootIndex + 1, inEnd);

        return root;
    }
}
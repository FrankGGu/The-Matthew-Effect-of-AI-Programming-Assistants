public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    private Map<Integer, Integer> indexMap = new HashMap<>();
    private int[] preorder;

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        for (int i = 0; i < inorder.length; i++) {
            indexMap.put(inorder[i], i);
        }
        this.preorder = preorder;
        return build(0, 0, inorder.length - 1);
    }

    private TreeNode build(int preStart, int inStart, int inEnd) {
        if (inStart > inEnd) {
            return null;
        }
        int rootVal = preorder[preStart];
        TreeNode root = new TreeNode(rootVal);
        int rootIndex = indexMap.get(rootVal);
        int leftSubtreeSize = rootIndex - inStart;
        root.left = build(preStart + 1, inStart, rootIndex - 1);
        root.right = build(preStart + 1 + leftSubtreeSize, rootIndex + 1, inEnd);
        return root;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}
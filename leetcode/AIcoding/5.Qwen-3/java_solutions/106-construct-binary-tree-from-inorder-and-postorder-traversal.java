public class Solution {

import java.util.HashMap;

public class Solution {
    private HashMap<Integer, Integer> map = new HashMap<>();
    private int postIndex;

    public TreeNode buildTree(int[] inorder, int[] postorder) {
        for (int i = 0; i < inorder.length; i++) {
            map.put(inorder[i], i);
        }
        postIndex = postorder.length - 1;
        return buildTree(inorder, postorder, 0, inorder.length - 1);
    }

    private TreeNode buildTree(int[] inorder, int[] postorder, int inStart, int inEnd) {
        if (inStart > inEnd) {
            return null;
        }
        int rootVal = postorder[postIndex];
        TreeNode root = new TreeNode(rootVal);
        int rootIndex = map.get(rootVal);
        postIndex--;
        root.right = buildTree(inorder, postorder, rootIndex + 1, inEnd);
        root.left = buildTree(inorder, postorder, inStart, rootIndex - 1);
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
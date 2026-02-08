import java.util.HashMap;

public class Solution {
    private int preIndex = 0;
    private HashMap<Integer, Integer> inIndexMap;

    public TreeNode buildTree(int[] preorder, int[] inorder) {
        inIndexMap = new HashMap<>();
        for (int i = 0; i < inorder.length; i++) {
            inIndexMap.put(inorder[i], i);
        }
        return buildTreeHelper(preorder, 0, inorder.length - 1);
    }

    private TreeNode buildTreeHelper(int[] preorder, int inStart, int inEnd) {
        if (inStart > inEnd) {
            return null;
        }
        int rootVal = preorder[preIndex++];
        TreeNode root = new TreeNode(rootVal);
        int inIndex = inIndexMap.get(rootVal);
        root.left = buildTreeHelper(preorder, inStart, inIndex - 1);
        root.right = buildTreeHelper(preorder, inIndex + 1, inEnd);
        return root;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}
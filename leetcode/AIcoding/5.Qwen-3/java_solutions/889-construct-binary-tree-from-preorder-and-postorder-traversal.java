public class Solution {

import java.util.HashMap;
import java.util.Map;

public class Solution {
    private Map<Integer, Integer> valueToIndex = new HashMap<>();
    private int preIndex = 0;

    public TreeNode buildTree(int[] preorder, int[] postorder) {
        for (int i = 0; i < postorder.length; i++) {
            valueToIndex.put(postorder[i], i);
        }
        return buildTree(preorder, postorder, 0, preorder.length - 1);
    }

    private TreeNode buildTree(int[] preorder, int[] postorder, int left, int right) {
        if (left > right) {
            return null;
        }
        if (left == right) {
            return new TreeNode(preorder[preIndex++]);
        }
        int rootVal = preorder[preIndex++];
        int rootPostIndex = valueToIndex.get(rootVal);
        int leftSubtreeSize = rootPostIndex - left;
        TreeNode leftNode = buildTree(preorder, postorder, left, rootPostIndex - 1);
        TreeNode rightNode = buildTree(preorder, postorder, rootPostIndex + 1, right);
        TreeNode root = new TreeNode(rootVal);
        root.left = leftNode;
        root.right = rightNode;
        return root;
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode(int x) {
            val = x;
        }
    }
}
}
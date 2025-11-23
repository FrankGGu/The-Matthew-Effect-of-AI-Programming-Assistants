public class Solution {

import java.util.*;

public class Solution {
    public TreeNode bstFromPreorder(int[] preorder) {
        return buildBST(preorder, 0, preorder.length - 1);
    }

    private TreeNode buildBST(int[] preorder, int start, int end) {
        if (start > end) return null;
        TreeNode root = new TreeNode(preorder[start]);
        int i = start + 1;
        while (i <= end && preorder[i] < preorder[start]) {
            i++;
        }
        root.left = buildBST(preorder, start + 1, i - 1);
        root.right = buildBST(preorder, i, end);
        return root;
    }

    public class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;
        TreeNode(int x) { val = x; }
    }
}
}
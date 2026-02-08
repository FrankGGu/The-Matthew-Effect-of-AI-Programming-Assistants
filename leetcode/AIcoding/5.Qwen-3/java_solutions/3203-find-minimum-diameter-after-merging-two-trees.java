public class Solution {

import java.util.*;

public class Solution {
    public int minimumDiameterAfterMerging(TreeNode root1, TreeNode root2) {
        int[] diameter1 = getDiameter(root1);
        int[] diameter2 = getDiameter(root2);
        return Math.min(diameter1[1], diameter2[1]);
    }

    private int[] getDiameter(TreeNode root) {
        if (root == null) {
            return new int[]{0, 0};
        }
        int[] left = getDiameter(root.left);
        int[] right = getDiameter(root.right);
        int height = 1 + Math.max(left[0], right[0]);
        int diameter = Math.max(Math.max(left[1], right[1]), left[0] + right[0] + 1);
        return new int[]{height, diameter};
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
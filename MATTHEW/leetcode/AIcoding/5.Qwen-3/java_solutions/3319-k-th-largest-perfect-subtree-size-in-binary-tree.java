public class Solution {

import java.util.*;

public class Solution {
    private int k;
    private List<Integer> sizes = new ArrayList<>();

    public int kthLargestPerfectSubtreeSize(TreeNode root, int k) {
        this.k = k;
        traverse(root);
        Collections.sort(sizes, Collections.reverseOrder());
        return sizes.get(k - 1);
    }

    private int traverse(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int left = traverse(node.left);
        int right = traverse(node.right);

        if (left == right && left != -1) {
            sizes.add(left + 1);
            return left + 1;
        } else {
            return -1;
        }
    }

    static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {}

        TreeNode(int val) {
            this.val = val;
        }

        TreeNode(int val, TreeNode left, TreeNode right) {
            this.val = val;
            this.left = left;
            this.right = right;
        }
    }
}
}
public class Solution {


class TreeNode {
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

public class Solution {
    public int[] findGameResults(TreeNode root, int n, int x) {
        int[] result = new int[2];
        countNodes(root, x, result);
        return result;
    }

    private int countNodes(TreeNode node, int x, int[] result) {
        if (node == null) {
            return 0;
        }
        int left = countNodes(node.left, x, result);
        int right = countNodes(node.right, x, result);
        if (node.val == x) {
            result[0] = left;
            result[1] = right;
        }
        return left + right + 1;
    }
}
}
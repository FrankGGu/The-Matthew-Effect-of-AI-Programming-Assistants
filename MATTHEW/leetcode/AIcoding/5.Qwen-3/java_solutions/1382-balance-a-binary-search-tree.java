public class Solution {

class Solution {
    public TreeNode balanceBST(TreeNode root) {
        java.util.List<Integer> list = new java.util.ArrayList<>();
        inorderTraversal(root, list);
        return buildBalancedBST(list, 0, list.size() - 1);
    }

    private void inorderTraversal(TreeNode node, java.util.List<Integer> list) {
        if (node == null) return;
        inorderTraversal(node.left, list);
        list.add(node.val);
        inorderTraversal(node.right, list);
    }

    private TreeNode buildBalancedBST(java.util.List<Integer> list, int left, int right) {
        if (left > right) return null;
        int mid = left + (right - left) / 2;
        TreeNode node = new TreeNode(list.get(mid));
        node.left = buildBalancedBST(list, left, mid - 1);
        node.right = buildBalancedBST(list, mid + 1, right);
        return node;
    }

    static class TreeNode {
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
}
}
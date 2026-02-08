class Solution {
    public TreeNode balanceBST(TreeNode root) {
        List<Integer> inorder = new ArrayList<>();
        inorderTraversal(root, inorder);
        return buildBalancedBST(inorder, 0, inorder.size() - 1);
    }

    private void inorderTraversal(TreeNode root, List<Integer> inorder) {
        if (root == null) {
            return;
        }
        inorderTraversal(root.left, inorder);
        inorder.add(root.val);
        inorderTraversal(root.right, inorder);
    }

    private TreeNode buildBalancedBST(List<Integer> inorder, int start, int end) {
        if (start > end) {
            return null;
        }
        int mid = start + (end - start) / 2;
        TreeNode root = new TreeNode(inorder.get(mid));
        root.left = buildBalancedBST(inorder, start, mid - 1);
        root.right = buildBalancedBST(inorder, mid + 1, end);
        return root;
    }
}
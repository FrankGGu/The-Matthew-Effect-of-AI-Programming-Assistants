class Solution {
    public TreeNode balanceBST(TreeNode root) {
        List<Integer> inorderList = new ArrayList<>();
        inorderTraversal(root, inorderList);
        return buildBalancedBST(inorderList, 0, inorderList.size() - 1);
    }

    private void inorderTraversal(TreeNode node, List<Integer> list) {
        if (node == null) return;
        inorderTraversal(node.left, list);
        list.add(node.val);
        inorderTraversal(node.right, list);
    }

    private TreeNode buildBalancedBST(List<Integer> list, int start, int end) {
        if (start > end) return null;
        int mid = start + (end - start) / 2;
        TreeNode node = new TreeNode(list.get(mid));
        node.left = buildBalancedBST(list, start, mid - 1);
        node.right = buildBalancedBST(list, mid + 1, end);
        return node;
    }
}
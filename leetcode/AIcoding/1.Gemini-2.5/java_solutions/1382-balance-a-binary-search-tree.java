import java.util.ArrayList;
import java.util.List;

class Solution {
    private List<TreeNode> sortedNodes;

    public TreeNode balanceBST(TreeNode root) {
        sortedNodes = new ArrayList<>();
        inorderTraversal(root);
        return buildBalancedBST(0, sortedNodes.size() - 1);
    }

    private void inorderTraversal(TreeNode node) {
        if (node == null) {
            return;
        }
        inorderTraversal(node.left);
        sortedNodes.add(node);
        inorderTraversal(node.right);
    }

    private TreeNode buildBalancedBST(int start, int end) {
        if (start > end) {
            return null;
        }

        int mid = start + (end - start) / 2;
        TreeNode root = sortedNodes.get(mid);

        root.left = buildBalancedBST(start, mid - 1);
        root.right = buildBalancedBST(mid + 1, end);

        return root;
    }
}
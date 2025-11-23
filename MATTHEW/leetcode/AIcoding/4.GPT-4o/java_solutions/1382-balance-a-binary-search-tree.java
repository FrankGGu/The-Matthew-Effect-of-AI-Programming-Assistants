import java.util.ArrayList;
import java.util.List;

public class Solution {
    public TreeNode balanceBST(TreeNode root) {
        List<TreeNode> nodes = new ArrayList<>();
        inorder(root, nodes);
        return buildBST(nodes, 0, nodes.size() - 1);
    }

    private void inorder(TreeNode node, List<TreeNode> nodes) {
        if (node == null) return;
        inorder(node.left, nodes);
        nodes.add(node);
        inorder(node.right, nodes);
    }

    private TreeNode buildBST(List<TreeNode> nodes, int start, int end) {
        if (start > end) return null;
        int mid = (start + end) / 2;
        TreeNode root = nodes.get(mid);
        root.left = buildBST(nodes, start, mid - 1);
        root.right = buildBST(nodes, mid + 1, end);
        return root;
    }
}

class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}
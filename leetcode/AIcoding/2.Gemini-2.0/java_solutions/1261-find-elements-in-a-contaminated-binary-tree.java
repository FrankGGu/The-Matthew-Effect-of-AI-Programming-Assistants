import java.util.HashSet;
import java.util.Set;

public class FindElements {

    private TreeNode root;
    private Set<Integer> values;

    public FindElements(TreeNode root) {
        this.root = root;
        this.values = new HashSet<>();
        if (root != null) {
            root.val = 0;
            recover(root);
        }
    }

    private void recover(TreeNode node) {
        values.add(node.val);
        if (node.left != null) {
            node.left.val = 2 * node.val + 1;
            recover(node.left);
        }
        if (node.right != null) {
            node.right.val = 2 * node.val + 2;
            recover(node.right);
        }
    }

    public boolean find(int target) {
        return values.contains(target);
    }

    public static class TreeNode {
        int val;
        TreeNode left;
        TreeNode right;

        TreeNode() {
        }

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
import java.util.HashSet;
import java.util.Set;

class FindElements {
    private Set<Integer> foundElements = new HashSet<>();

    public FindElements(TreeNode root) {
        if (root != null) {
            root.val = 0;
            recover(root);
        }
    }

    private void recover(TreeNode node) {
        if (node == null) return;
        foundElements.add(node.val);
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
        return foundElements.contains(target);
    }
}
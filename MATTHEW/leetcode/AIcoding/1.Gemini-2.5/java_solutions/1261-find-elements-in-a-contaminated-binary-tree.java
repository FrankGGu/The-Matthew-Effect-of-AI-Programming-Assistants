import java.util.HashSet;
import java.util.Set;

class FindElements {
    private Set<Integer> recoveredValues;

    public FindElements(TreeNode root) {
        recoveredValues = new HashSet<>();
        recover(root, 0);
    }

    private void recover(TreeNode node, int value) {
        if (node == null) {
            return;
        }
        recoveredValues.add(value);

        if (node.left != null) {
            recover(node.left, 2 * value + 1);
        }
        if (node.right != null) {
            recover(node.right, 2 * value + 2);
        }
    }

    public boolean find(int target) {
        return recoveredValues.contains(target);
    }
}
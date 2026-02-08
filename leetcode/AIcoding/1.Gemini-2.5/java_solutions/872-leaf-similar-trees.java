import java.util.ArrayList;
import java.util.List;

class Solution {
    public boolean leafSimilar(TreeNode root1, TreeNode root2) {
        List<Integer> leaves1 = new ArrayList<>();
        List<Integer> leaves2 = new ArrayList<>();

        collectLeafValues(root1, leaves1);
        collectLeafValues(root2, leaves2);

        return leaves1.equals(leaves2);
    }

    private void collectLeafValues(TreeNode node, List<Integer> leafValues) {
        if (node == null) {
            return;
        }

        if (node.left == null && node.right == null) {
            leafValues.add(node.val);
            return;
        }

        collectLeafValues(node.left, leafValues);
        collectLeafValues(node.right, leafValues);
    }
}
import java.util.List;

public class FlipBinaryTreeToMatchPreorderTraversal {

    private int index = 0;
    private List<Integer> result;
    private int[] voyage;

    public List<Integer> flipMatchVoyage(TreeNode root, int[] voyage) {
        this.index = 0;
        this.result = new java.util.ArrayList<>();
        this.voyage = voyage;
        if (flipMatchVoyageHelper(root)) {
            return result;
        } else {
            return java.util.Arrays.asList(-1);
        }
    }

    private boolean flipMatchVoyageHelper(TreeNode node) {
        if (node == null) {
            return true;
        }
        if (node.val != voyage[index++]) {
            return false;
        }

        if (node.left != null && node.left.val != voyage[index] &&
            node.right != null && node.right.val == voyage[index]) {
            result.add(node.val);
            TreeNode temp = node.left;
            node.left = node.right;
            node.right = temp;
        }

        return flipMatchVoyageHelper(node.left) && flipMatchVoyageHelper(node.right);
    }

    public class TreeNode {
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
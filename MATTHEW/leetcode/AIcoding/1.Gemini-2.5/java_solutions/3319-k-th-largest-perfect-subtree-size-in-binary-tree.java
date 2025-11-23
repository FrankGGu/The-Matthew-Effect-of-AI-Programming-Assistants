import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

class Solution {
    private List<Integer> perfectSubtreeSizes;

    public int kthLargestPerfectSubtreeSize(TreeNode root, int k) {
        perfectSubtreeSizes = new ArrayList<>();

        getPerfectSubtreeHeight(root);

        if (perfectSubtreeSizes.size() < k) {
            return -1; 
        }

        Collections.sort(perfectSubtreeSizes, Collections.reverseOrder());

        return perfectSubtreeSizes.get(k - 1);
    }

    private int getPerfectSubtreeHeight(TreeNode node) {
        if (node == null) {
            return 0;
        }

        int leftHeight = getPerfectSubtreeHeight(node.left);
        int rightHeight = getPerfectSubtreeHeight(node.right);

        if (leftHeight == rightHeight) {
            int currentHeight = leftHeight + 1;
            perfectSubtreeSizes.add((1 << currentHeight) - 1);
            return currentHeight;
        } else {
            perfectSubtreeSizes.add(1);
            return 1;
        }
    }
}
import java.util.HashSet;
import java.util.Set;

class Solution {
    public boolean findTarget(TreeNode root, int k) {
        Set<Integer> seen = new HashSet<>();
        return findTargetHelper(root, k, seen);
    }

    private boolean findTargetHelper(TreeNode root, int k, Set<Integer> seen) {
        if (root == null) {
            return false;
        }

        if (seen.contains(k - root.val)) {
            return true;
        }

        seen.add(root.val);

        return findTargetHelper(root.left, k, seen) || findTargetHelper(root.right, k, seen);
    }
}
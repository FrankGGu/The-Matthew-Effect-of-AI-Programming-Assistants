public class Solution {


class TreeNode {
    int val;
    TreeNode left;
    TreeNode right;
    TreeNode(int x) { val = x; }
}

public class Solution {
    public boolean findTarget(TreeNode root, int target) {
        return findTarget(root, target, new java.util.HashSet<Integer>());
    }

    private boolean findTarget(TreeNode root, int target, java.util.Set<Integer> set) {
        if (root == null) {
            return false;
        }
        if (set.contains(target - root.val)) {
            return true;
        }
        set.add(root.val);
        return findTarget(root.left, target, set) || findTarget(root.right, target, set);
    }
}
}
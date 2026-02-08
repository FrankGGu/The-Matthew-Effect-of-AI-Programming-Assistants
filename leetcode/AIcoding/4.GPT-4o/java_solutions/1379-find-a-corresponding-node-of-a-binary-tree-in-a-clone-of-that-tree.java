class Solution {
    public final TreeNode getTargetCopy(final TreeNode original, final TreeNode cloned, final TreeNode target) {
        if (cloned == null) return null;
        if (cloned == target) return cloned;

        TreeNode leftResult = getTargetCopy(original, cloned.left, target);
        if (leftResult != null) return leftResult;

        return getTargetCopy(original, cloned.right, target);
    }
}
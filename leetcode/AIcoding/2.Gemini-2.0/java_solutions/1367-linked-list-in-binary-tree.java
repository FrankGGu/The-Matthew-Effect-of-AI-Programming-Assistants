class Solution {
    public boolean isSubPath(ListNode head, TreeNode root) {
        if (head == null) return true;
        if (root == null) return false;

        return isSubPathHelper(head, root) || isSubPath(head, root.left) || isSubPath(head, root.right);
    }

    private boolean isSubPathHelper(ListNode head, TreeNode root) {
        if (head == null) return true;
        if (root == null) return false;

        if (head.val != root.val) return false;

        return isSubPathHelper(head.next, root.left) || isSubPathHelper(head.next, root.right);
    }
}
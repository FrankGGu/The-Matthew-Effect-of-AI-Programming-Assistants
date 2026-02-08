class Solution {
    private ListNode currentHead;

    public TreeNode sortedListToBST(ListNode head) {
        if (head == null) {
            return null;
        }

        this.currentHead = head;

        int length = 0;
        ListNode temp = head;
        while (temp != null) {
            length++;
            temp = temp.next;
        }

        return buildBST(0, length - 1);
    }

    private TreeNode buildBST(int start, int end) {
        if (start > end) {
            return null;
        }

        int mid = start + (end - start) / 2;

        TreeNode leftChild = buildBST(start, mid - 1);

        TreeNode root = new TreeNode(currentHead.val);
        currentHead = currentHead.next;

        root.left = leftChild;
        root.right = buildBST(mid + 1, end);

        return root;
    }
}
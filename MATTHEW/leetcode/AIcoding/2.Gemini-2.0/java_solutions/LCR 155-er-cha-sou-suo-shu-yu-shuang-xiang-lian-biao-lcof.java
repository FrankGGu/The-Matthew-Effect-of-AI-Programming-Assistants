class Solution {
    Node head = null;
    Node pre = null;

    public Node treeToDoublyList(Node root) {
        if (root == null) return null;
        inorder(root);
        pre.right = head;
        head.left = pre;
        return head;
    }

    private void inorder(Node root) {
        if (root == null) return;
        inorder(root.left);
        if (pre == null) {
            head = root;
        } else {
            pre.right = root;
            root.left = pre;
        }
        pre = root;
        inorder(root.right);
    }
}
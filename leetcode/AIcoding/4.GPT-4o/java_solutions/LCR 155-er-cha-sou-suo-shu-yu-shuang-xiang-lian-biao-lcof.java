class Node {
    public int val;
    public Node left;
    public Node right;
    public Node() {}
    public Node(int _val) {
        val = _val;
    }
    public Node(int _val, Node _left, Node _right) {
        val = _val;
        left = _left;
        right = _right;
    }
}

class Solution {
    private Node prev = null;
    private Node head = null;

    public Node treeToDoublyList(Node root) {
        if (root == null) return null;
        inOrder(root);
        head.left = prev;
        prev.right = head;
        return head;
    }

    private void inOrder(Node node) {
        if (node == null) return;
        inOrder(node.left);
        if (prev == null) head = node;
        else {
            prev.right = node;
            node.left = prev;
        }
        prev = node;
        inOrder(node.right);
    }
}
public class Solution {
    Node head = null;
    Node prev = null;

    public Node treeToDoublyList(Node root) {
        if (root == null) return null;
        inorder(root);
        head.left = prev;
        prev.right = head;
        return head;
    }

    private void inorder(Node node) {
        if (node == null) return;
        inorder(node.left);
        if (prev == null) {
            head = node;
        } else {
            node.left = prev;
            prev.right = node;
        }
        prev = node;
        inorder(node.right);
    }

    static class Node {
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
}
class Solution {
    Node first = null;
    Node last = null;

    public Node treeToDoublyList(Node root) {
        if (root == null) return null;
        helper(root);
        last.right = first;
        first.left = last;
        return first;
    }

    private void helper(Node node) {
        if (node == null) return;
        helper(node.left);
        if (last != null) {
            last.right = node;
            node.left = last;
        } else {
            first = node;
        }
        last = node;
        helper(node.right);
    }
}
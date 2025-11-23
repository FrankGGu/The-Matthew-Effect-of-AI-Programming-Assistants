class Solution {
    public Node connect(Node root) {
        if (root == null) {
            return null;
        }

        Node leftmost = root;

        while (leftmost.left != null) {
            Node current = leftmost;
            while (current != null) {
                // Connect children of the current node
                current.left.next = current.right;

                // Connect the right child of the current node to the left child of the next node
                if (current.next != null) {
                    current.right.next = current.next.left;
                }

                // Move to the next node in the current level
                current = current.next;
            }
            // Move to the next level
            leftmost = leftmost.left;
        }

        return root;
    }
}
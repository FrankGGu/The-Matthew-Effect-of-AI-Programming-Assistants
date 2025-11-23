public class Solution {

class Node {
    public int val;
    public Node left;
    public Node right;
    public Node next;

    public Node() {}

    public Node(int _val) {
        val = _val;
    }

    public Node(int _val, Node _left, Node _right, Node _next) {
        val = _val;
        left = _left;
        right = _right;
        next = _next;
    }
}

public class Solution {
    public void connect(Node root) {
        Node levelStart = root;
        while (levelStart != null) {
            Node curr = levelStart;
            Node prev = null;
            while (curr != null) {
                if (curr.left != null) {
                    if (prev != null) {
                        prev.next = curr.left;
                    } else {
                        levelStart = curr.left;
                    }
                    prev = curr.left;
                }
                if (curr.right != null) {
                    if (prev != null) {
                        prev.next = curr.right;
                    } else {
                        levelStart = curr.right;
                    }
                    prev = curr.right;
                }
                curr = curr.next;
            }
        }
    }
}
}
import java.util.HashMap;

class Solution {
    public Node copyRandomList(Node head) {
        if (head == null) {
            return null;
        }

        HashMap<Node, Node> oldToNew = new HashMap<>();

        Node current = head;
        while (current != null) {
            oldToNew.put(current, new Node(current.val));
            current = current.next;
        }

        current = head;
        while (current != null) {
            Node newNode = oldToNew.get(current);
            newNode.next = oldToNew.get(current.next);
            newNode.random = oldToNew.get(current.random);
            current = current.next;
        }

        return oldToNew.get(head);
    }
}
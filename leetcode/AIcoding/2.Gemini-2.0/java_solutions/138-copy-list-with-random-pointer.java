import java.util.HashMap;

public class Solution {
    public Node copyRandomList(Node head) {
        if (head == null) return null;

        HashMap<Node, Node> map = new HashMap<>();
        Node current = head;

        while (current != null) {
            map.put(current, new Node(current.val));
            current = current.next;
        }

        current = head;
        while (current != null) {
            Node newNode = map.get(current);
            newNode.next = (current.next != null) ? map.get(current.next) : null;
            newNode.random = (current.random != null) ? map.get(current.random) : null;
            current = current.next;
        }

        return map.get(head);
    }
}
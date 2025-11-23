import java.util.HashMap;
import java.util.HashSet;
import java.util.Map;
import java.util.Set;

class AllOne {

    private static class Node {
        int count;
        Set<String> keys;
        Node prev;
        Node next;

        public Node(int count) {
            this.count = count;
            this.keys = new HashSet<>();
        }
    }

    private Map<String, Node> keyToNode;
    private Node head;
    private Node tail;

    public AllOne() {
        keyToNode = new HashMap<>();
        head = new Node(0);
        tail = new Node(0);
        head.next = tail;
        tail.prev = head;
    }

    private Node addNodeAfter(Node prevNode, int count) {
        Node newNode = new Node(count);
        newNode.prev = prevNode;
        newNode.next = prevNode.next;
        prevNode.next.prev = newNode;
        prevNode.next = newNode;
        return newNode;
    }

    private void removeNode(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    public void inc(String key) {
        if (keyToNode.containsKey(key)) {
            Node oldNode = keyToNode.get(key);
            oldNode.keys.remove(key);

            int newCount = oldNode.count + 1;
            Node newNode;

            if (oldNode.next.count == newCount) {
                newNode = oldNode.next;
            } else {
                newNode = addNodeAfter(oldNode, newCount);
            }
            newNode.keys.add(key);
            keyToNode.put(key, newNode);

            if (oldNode.keys.isEmpty()) {
                removeNode(oldNode);
            }

        } else {
            int newCount = 1;
            Node newNode;

            if (head.next.count == newCount) {
                newNode = head.next;
            } else {
                newNode = addNodeAfter(head, newCount);
            }
            newNode.keys.add(key);
            keyToNode.put(key, newNode);
        }
    }

    public void dec(String key) {
        if (!keyToNode.containsKey(key)) {
            return;
        }

        Node oldNode = keyToNode.get(key);
        oldNode.keys.remove(key);

        int newCount = oldNode.count - 1;

        if (newCount == 0) {
            keyToNode.remove(key);
        } else {
            Node newNode;
            if (oldNode.prev.count == newCount) {
                newNode = oldNode.prev;
            } else {
                newNode = addNodeAfter(oldNode.prev, newCount);
            }
            newNode.keys.add(key);
            keyToNode.put(key, newNode);
        }

        if (oldNode.keys.isEmpty()) {
            removeNode(oldNode);
        }
    }

    public String getMaxKey() {
        if (tail.prev == head) {
            return "";
        }
        return tail.prev.keys.iterator().next();
    }

    public String getMinKey() {
        if (head.next == tail) {
            return "";
        }
        return head.next.keys.iterator().next();
    }
}
import java.util.*;

class AllOne {
    class Node {
        int count;
        Set<String> keys;
        Node prev, next;
        Node(int count) {
            this.count = count;
            this.keys = new HashSet<>();
        }
    }

    private Map<String, Integer> keyCount;
    private Map<Integer, Node> countNode;
    private Node head, tail;

    public AllOne() {
        keyCount = new HashMap<>();
        countNode = new HashMap<>();
        head = new Node(Integer.MIN_VALUE);
        tail = new Node(Integer.MAX_VALUE);
        head.next = tail;
        tail.prev = head;
    }

    private void addNodeAfter(Node newNode, Node prevNode) {
        newNode.prev = prevNode;
        newNode.next = prevNode.next;
        prevNode.next.prev = newNode;
        prevNode.next = newNode;
    }

    private void removeNode(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    public void inc(String key) {
        if (keyCount.containsKey(key)) {
            int count = keyCount.get(key);
            Node node = countNode.get(count);
            node.keys.remove(key);
            int newCount = count + 1;
            keyCount.put(key, newCount);
            Node newNode;
            if (countNode.containsKey(newCount)) {
                newNode = countNode.get(newCount);
            } else {
                newNode = new Node(newCount);
                countNode.put(newCount, newNode);
                addNodeAfter(newNode, node);
            }
            newNode.keys.add(key);
            if (node.keys.isEmpty()) {
                removeNode(node);
                countNode.remove(count);
            }
        } else {
            keyCount.put(key, 1);
            Node newNode;
            if (countNode.containsKey(1)) {
                newNode = countNode.get(1);
            } else {
                newNode = new Node(1);
                countNode.put(1, newNode);
                addNodeAfter(newNode, head);
            }
            newNode.keys.add(key);
        }
    }

    public void dec(String key) {
        if (!keyCount.containsKey(key)) return;
        int count = keyCount.get(key);
        Node node = countNode.get(count);
        node.keys.remove(key);
        if (count == 1) {
            keyCount.remove(key);
        } else {
            int newCount = count - 1;
            keyCount.put(key, newCount);
            Node newNode;
            if (countNode.containsKey(newCount)) {
                newNode = countNode.get(newCount);
            } else {
                newNode = new Node(newCount);
                countNode.put(newCount, newNode);
                addNodeAfter(newNode, node.prev);
            }
            newNode.keys.add(key);
        }
        if (node.keys.isEmpty()) {
            removeNode(node);
            countNode.remove(count);
        }
    }

    public String getMaxKey() {
        if (tail.prev == head) return "";
        return tail.prev.keys.iterator().next();
    }

    public String getMinKey() {
        if (head.next == tail) return "";
        return head.next.keys.iterator().next();
    }
}
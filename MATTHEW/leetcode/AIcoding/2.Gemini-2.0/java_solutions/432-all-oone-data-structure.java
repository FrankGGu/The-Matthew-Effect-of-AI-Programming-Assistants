class AllOne {

    private static class Node {
        int count;
        Set<String> keys;
        Node prev, next;

        Node(int count) {
            this.count = count;
            this.keys = new HashSet<>();
        }
    }

    private final Node head, tail;
    private final Map<String, Node> keyToNode;

    public AllOne() {
        head = new Node(0);
        tail = new Node(0);
        head.next = tail;
        tail.prev = head;
        keyToNode = new HashMap<>();
    }

    public void inc(String key) {
        if (!keyToNode.containsKey(key)) {
            if (head.next.count != 1) {
                addNodeAfter(head, new Node(1));
            }
            head.next.keys.add(key);
            keyToNode.put(key, head.next);
        } else {
            Node node = keyToNode.get(key);
            node.keys.remove(key);
            int count = node.count;
            if (node.next.count != count + 1) {
                addNodeAfter(node, new Node(count + 1));
            }
            node.next.keys.add(key);
            keyToNode.put(key, node.next);
            if (node.keys.isEmpty()) {
                removeNode(node);
            }
        }
    }

    public void dec(String key) {
        if (!keyToNode.containsKey(key)) {
            return;
        }

        Node node = keyToNode.get(key);
        node.keys.remove(key);
        int count = node.count;
        if (count == 1) {
            keyToNode.remove(key);
        } else {
            if (node.prev.count != count - 1) {
                addNodeAfter(node.prev, new Node(count - 1));
            }
            node.prev.keys.add(key);
            keyToNode.put(key, node.prev);
        }
        if (node.keys.isEmpty()) {
            removeNode(node);
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

    private void addNodeAfter(Node node, Node newNode) {
        newNode.prev = node;
        newNode.next = node.next;
        node.next.prev = newNode;
        node.next = newNode;
    }

    private void removeNode(Node node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
}
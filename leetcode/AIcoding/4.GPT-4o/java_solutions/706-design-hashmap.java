class MyHashMap {
    private class Node {
        int key, value;
        Node next;
        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    private Node[] buckets;
    private static final int SIZE = 10000;

    public MyHashMap() {
        buckets = new Node[SIZE];
    }

    private int getHash(int key) {
        return Integer.hashCode(key) % SIZE;
    }

    public void put(int key, int value) {
        int hash = getHash(key);
        if (buckets[hash] == null) {
            buckets[hash] = new Node(-1, -1);
        }
        Node prev = findNode(buckets[hash], key);
        if (prev.next == null) {
            prev.next = new Node(key, value);
        } else {
            prev.next.value = value;
        }
    }

    public int get(int key) {
        int hash = getHash(key);
        if (buckets[hash] == null) {
            return -1;
        }
        Node node = findNode(buckets[hash], key);
        return node.next == null ? -1 : node.next.value;
    }

    public void remove(int key) {
        int hash = getHash(key);
        if (buckets[hash] == null) {
            return;
        }
        Node prev = findNode(buckets[hash], key);
        if (prev.next != null) {
            prev.next = prev.next.next;
        }
    }

    private Node findNode(Node bucket, int key) {
        Node prev = bucket;
        Node curr = bucket.next;
        while (curr != null && curr.key != key) {
            prev = curr;
            curr = curr.next;
        }
        return prev;
    }
}
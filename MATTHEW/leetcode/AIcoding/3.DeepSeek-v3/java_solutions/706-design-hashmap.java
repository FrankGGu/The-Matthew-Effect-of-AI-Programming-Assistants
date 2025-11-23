class MyHashMap {
    private static final int SIZE = 10000;
    private Node[] buckets;

    private static class Node {
        int key;
        int value;
        Node next;

        Node(int key, int value) {
            this.key = key;
            this.value = value;
        }
    }

    public MyHashMap() {
        buckets = new Node[SIZE];
    }

    public void put(int key, int value) {
        int index = getIndex(key);
        Node prev = findPrev(index, key);
        if (prev.next == null) {
            prev.next = new Node(key, value);
        } else {
            prev.next.value = value;
        }
    }

    public int get(int key) {
        int index = getIndex(key);
        Node prev = findPrev(index, key);
        return prev.next == null ? -1 : prev.next.value;
    }

    public void remove(int key) {
        int index = getIndex(key);
        Node prev = findPrev(index, key);
        if (prev.next != null) {
            prev.next = prev.next.next;
        }
    }

    private int getIndex(int key) {
        return Integer.hashCode(key) % SIZE;
    }

    private Node findPrev(int index, int key) {
        if (buckets[index] == null) {
            buckets[index] = new Node(-1, -1);
            return buckets[index];
        }
        Node prev = buckets[index];
        while (prev.next != null && prev.next.key != key) {
            prev = prev.next;
        }
        return prev;
    }
}
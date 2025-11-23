class MyHashMap {

    private static final int DEFAULT_CAPACITY = 16;
    private static final float LOAD_FACTOR = 0.75f;

    private Node[] table;
    private int size;
    private int capacity;

    public MyHashMap() {
        capacity = DEFAULT_CAPACITY;
        table = new Node[capacity];
        size = 0;
    }

    private int hash(int key) {
        return Integer.hashCode(key) % capacity;
    }

    public void put(int key, int value) {
        int index = hash(key);
        if (table[index] == null) {
            table[index] = new Node(key, value, null);
            size++;
        } else {
            Node current = table[index];
            while (current != null) {
                if (current.key == key) {
                    current.value = value;
                    return;
                }
                if (current.next == null) {
                    break;
                }
                current = current.next;
            }
            current.next = new Node(key, value, null);
            size++;
        }

        if ((float) size / capacity > LOAD_FACTOR) {
            resize();
        }
    }

    public int get(int key) {
        int index = hash(key);
        Node current = table[index];
        while (current != null) {
            if (current.key == key) {
                return current.value;
            }
            current = current.next;
        }
        return -1;
    }

    public void remove(int key) {
        int index = hash(key);
        if (table[index] == null) {
            return;
        }

        if (table[index].key == key) {
            table[index] = table[index].next;
            size--;
            return;
        }

        Node current = table[index];
        while (current.next != null) {
            if (current.next.key == key) {
                current.next = current.next.next;
                size--;
                return;
            }
            current = current.next;
        }
    }

    private void resize() {
        capacity *= 2;
        Node[] oldTable = table;
        table = new Node[capacity];
        size = 0;

        for (Node node : oldTable) {
            Node current = node;
            while (current != null) {
                put(current.key, current.value);
                current = current.next;
            }
        }
    }

    private static class Node {
        int key;
        int value;
        Node next;

        public Node(int key, int value, Node next) {
            this.key = key;
            this.value = value;
            this.next = next;
        }
    }
}
import java.util.HashMap;
import java.util.Map;

class LFUCache {

    private static class Node {
        int key;
        int value;
        int freq;
        Node prev;
        Node next;

        public Node(int key, int value, int freq) {
            this.key = key;
            this.value = value;
            this.freq = freq;
        }
    }

    private static class DoublyLinkedList {
        Node head;
        Node tail;
        int size;

        public DoublyLinkedList() {
            head = new Node(-1, -1, -1);
            tail = new Node(-1, -1, -1);
            head.next = tail;
            tail.prev = head;
            size = 0;
        }

        public void addNode(Node node) {
            node.next = head.next;
            node.prev = head;
            head.next.prev = node;
            head.next = node;
            size++;
        }

        public void removeNode(Node node) {
            node.prev.next = node.next;
            node.next.prev = node.prev;
            node.next = null;
            node.prev = null;
            size--;
        }

        public Node getTail() {
            return tail.prev;
        }

        public boolean isEmpty() {
            return size == 0;
        }
    }

    private int capacity;
    private int size;
    private int minFreq;
    private Map<Integer, Node> cache;
    private Map<Integer, DoublyLinkedList> freqMap;

    public LFUCache(int capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.minFreq = 0;
        this.cache = new HashMap<>();
        this.freqMap = new HashMap<>();
    }

    public int get(int key) {
        if (!cache.containsKey(key)) {
            return -1;
        }

        Node node = cache.get(key);
        int val = node.value;

        updateNodeFrequency(node);

        return val;
    }

    public void put(int key, int value) {
        if (capacity == 0) {
            return;
        }

        if (cache.containsKey(key)) {
            Node node = cache.get(key);
            node.value = value;
            updateNodeFrequency(node);
            return;
        }

        if (size == capacity) {
            DoublyLinkedList lfuList = freqMap.get(minFreq);
            Node lruNode = lfuList.getTail();
            lfuList.removeNode(lruNode);
            cache.remove(lruNode.key);
            size--;
        }

        Node newNode = new Node(key, value, 1);
        cache.put(key, newNode);
        freqMap.computeIfAbsent(1, k -> new DoublyLinkedList()).addNode(newNode);
        minFreq = 1;
        size++;
    }

    private void updateNodeFrequency(Node node) {
        DoublyLinkedList oldList = freqMap.get(node.freq);
        oldList.removeNode(node);

        if (oldList.isEmpty() && node.freq == minFreq) {
            minFreq++;
        }

        node.freq++;

        freqMap.computeIfAbsent(node.freq, k -> new DoublyLinkedList()).addNode(node);
    }
}
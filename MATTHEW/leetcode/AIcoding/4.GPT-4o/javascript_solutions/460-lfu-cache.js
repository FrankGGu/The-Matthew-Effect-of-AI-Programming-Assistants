class Node {
    constructor(key, value) {
        this.key = key;
        this.value = value;
        this.freq = 1;
        this.prev = null;
        this.next = null;
    }
}

class DoubleLinkedList {
    constructor() {
        this.head = new Node(0, 0);
        this.tail = new Node(0, 0);
        this.head.next = this.tail;
        this.tail.prev = this.head;
        this.size = 0;
    }

    addNode(node) {
        node.prev = this.head;
        node.next = this.head.next;
        this.head.next.prev = node;
        this.head.next = node;
        this.size++;
    }

    removeNode(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        this.size--;
    }

    isEmpty() {
        return this.size === 0;
    }
}

class LFUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.minFreq = 0;
        this.keyNodeMap = new Map();
        this.freqListMap = new Map();
    }

    get(key) {
        if (!this.keyNodeMap.has(key)) return -1;
        const node = this.keyNodeMap.get(key);
        this.updateNode(node);
        return node.value;
    }

    put(key, value) {
        if (this.capacity <= 0) return;
        if (this.keyNodeMap.has(key)) {
            const node = this.keyNodeMap.get(key);
            node.value = value;
            this.updateNode(node);
        } else {
            if (this.keyNodeMap.size >= this.capacity) {
                const minFreqList = this.freqListMap.get(this.minFreq);
                const nodeToRemove = minFreqList.tail.prev;
                minFreqList.removeNode(nodeToRemove);
                this.keyNodeMap.delete(nodeToRemove.key);
            }
            const newNode = new Node(key, value);
            this.keyNodeMap.set(key, newNode);
            this.minFreq = 1;
            if (!this.freqListMap.has(1)) {
                this.freqListMap.set(1, new DoubleLinkedList());
            }
            this.freqListMap.get(1).addNode(newNode);
        }
    }

    updateNode(node) {
        const freq = node.freq;
        const freqList = this.freqListMap.get(freq);
        freqList.removeNode(node);
        if (freqList.isEmpty() && freq === this.minFreq) {
            this.minFreq++;
        }
        node.freq++;
        if (!this.freqListMap.has(node.freq)) {
            this.freqListMap.set(node.freq, new DoubleLinkedList());
        }
        this.freqListMap.get(node.freq).addNode(node);
    }
}
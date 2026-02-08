class Node {
    constructor(key) {
        this.key = key;
        this.prev = null;
        this.next = null;
    }
}

class DoublyLinkedList {
    constructor() {
        this.head = new Node(null);
        this.tail = new Node(null);
        this.head.next = this.tail;
        this.tail.prev = this.head;
        this.size = 0;
    }

    add(node) {
        node.prev = this.tail.prev;
        node.next = this.tail;
        this.tail.prev.next = node;
        this.tail.prev = node;
        this.size++;
    }

    remove(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
        node.prev = null;
        node.next = null;
        this.size--;
    }

    popHead() {
        if (this.size === 0) return null;
        const nodeToRemove = this.head.next;
        this.remove(nodeToRemove);
        return nodeToRemove;
    }

    isEmpty() {
        return this.size === 0;
    }
}

class LFUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.size = 0;
        this.minFreq = 0; 

        this.keyToEntry = new Map();
        this.freqToLists = new Map();
    }

    _updateFrequency(key) {
        const entry = this.keyToEntry.get(key);
        const oldFreq = entry.freq;
        const newFreq = oldFreq + 1;

        const oldList = this.freqToLists.get(oldFreq);
        oldList.remove(entry.nodeRef);

        if (oldList.isEmpty() && oldFreq === this.minFreq) {
            this.minFreq = newFreq;
        }

        if (!this.freqToLists.has(newFreq)) {
            this.freqToLists.set(newFreq, new DoublyLinkedList());
        }
        const newList = this.freqToLists.get(newFreq);

        const newNode = new Node(key); 
        newList.add(newNode);

        entry.freq = newFreq;
        entry.nodeRef = newNode; 
    }

    get(key) {
        if (!this.keyToEntry.has(key)) {
            return -1;
        }

        const entry = this.keyToEntry.get(key);
        this._updateFrequency(key);
        return entry.value;
    }

    put(key, value) {
        if (this.capacity === 0) {
            return;
        }

        if (this.keyToEntry.has(key)) {
            const entry = this.keyToEntry.get(key);
            entry.value = value;
            this._updateFrequency(key);
            return;
        }

        if (this.size === this.capacity) {
            const listToEvict = this.freqToLists.get(this.minFreq);
            const lruNode = listToEvict.popHead(); 
            this.keyToEntry.delete(lruNode.key); 
            this.size--;
        }

        const newFreq = 1;
        if (!this.freqToLists.has(newFreq)) {
            this.freqToLists.set(newFreq, new DoublyLinkedList());
        }
        const newList = this.freqToLists.get(newFreq);
        const newNode = new Node(key);
        newList.add(newNode);

        this.keyToEntry.set(key, {
            value: value,
            freq: newFreq,
            nodeRef: newNode
        });

        this.minFreq = newFreq; 
        this.size++;
    }
}
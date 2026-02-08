class Node {
    constructor(key, value) {
        this.key = key;
        this.value = value;
        this.prev = null;
        this.next = null;
    }
}

class LRUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.cacheMap = new Map();
        this.head = new Node(0, 0);
        this.tail = new Node(0, 0);
        this.head.next = this.tail;
        this.tail.prev = this.head;
    }

    _addNode(node) {
        node.prev = this.head;
        node.next = this.head.next;
        this.head.next.prev = node;
        this.head.next = node;
    }

    _removeNode(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    _moveToHead(node) {
        this._removeNode(node);
        this._addNode(node);
    }

    _popTail() {
        const res = this.tail.prev;
        this._removeNode(res);
        return res;
    }

    get(key) {
        if (!this.cacheMap.has(key)) {
            return -1;
        }
        const node = this.cacheMap.get(key);
        this._moveToHead(node);
        return node.value;
    }

    put(key, value) {
        if (this.cacheMap.has(key)) {
            const node = this.cacheMap.get(key);
            node.value = value;
            this._moveToHead(node);
        } else {
            const newNode = new Node(key, value);
            this.cacheMap.set(key, newNode);
            this._addNode(newNode);

            if (this.cacheMap.size > this.capacity) {
                const tailNode = this._popTail();
                this.cacheMap.delete(tailNode.key);
            }
        }
    }
}
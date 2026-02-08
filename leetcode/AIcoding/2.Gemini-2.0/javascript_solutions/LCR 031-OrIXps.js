class LRUCache {
    constructor(capacity) {
        this.capacity = capacity;
        this.cache = new Map();
        this.head = null;
        this.tail = null;
    }

    get(key) {
        if (!this.cache.has(key)) {
            return -1;
        }
        const node = this.cache.get(key);
        this.moveToHead(node);
        return node.value;
    }

    put(key, value) {
        if (this.cache.has(key)) {
            const node = this.cache.get(key);
            node.value = value;
            this.moveToHead(node);
        } else {
            const node = { key, value, next: null, prev: null };
            this.cache.set(key, node);
            this.addToHead(node);
            if (this.cache.size > this.capacity) {
                this.removeTail();
            }
        }
    }

    addToHead(node) {
        node.next = this.head;
        node.prev = null;
        if (this.head) {
            this.head.prev = node;
        }
        this.head = node;
        if (!this.tail) {
            this.tail = node;
        }
    }

    removeNode(node) {
        if (node.prev) {
            node.prev.next = node.next;
        } else {
            this.head = node.next;
        }

        if (node.next) {
            node.next.prev = node.prev;
        } else {
            this.tail = node.prev;
        }
    }

    moveToHead(node) {
        this.removeNode(node);
        this.addToHead(node);
    }

    removeTail() {
        const key = this.tail.key;
        this.cache.delete(key);
        this.removeNode(this.tail);
    }
}
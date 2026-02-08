function Node(key, value) {
    this.key = key;
    this.value = value;
    this.prev = null;
    this.next = null;
}

var LRUCache = function(capacity) {
    this.capacity = capacity;
    this.cache = new Map(); // Stores key -> Node object
    this.head = new Node(0, 0); // Dummy head node
    this.tail = new Node(0, 0); // Dummy tail node
    this.head.next = this.tail;
    this.tail.prev = this.head;
};

LRUCache.prototype.get = function(key) {
    if (this.cache.has(key)) {
        let node = this.cache.get(key);
        this._remove(node); // Remove from its current position
        this._add(node);    // Add to the head (most recently used)
        return node.value;
    }
    return -1;
};

LRUCache.prototype.put = function(key, value) {
    if (this.cache.has(key)) {
        // Key already exists, update value and move to head
        let node = this.cache.get(key);
        node.value = value;
        this._remove(node);
        this._add(node);
    } else {
        // New key
        let newNode = new Node(key, value);
        this.cache.set(key, newNode);
        this._add(newNode);

        // Check capacity
        if (this.cache.size > this.capacity) {
            // Remove LRU item (the one before the dummy tail)
            let lruNode = this.tail.prev;
            this._remove(lruNode);
            this.cache.delete(lruNode.key);
        }
    }
};

LRUCache.prototype._remove = function(node) {
    node.prev.next = node.next;
    node.next.prev = node.prev;
};

LRUCache.prototype._add = function(node) {
    node.next = this.head.next;
    node.prev = this.head;
    this.head.next.prev = node;
    this.head.next = node;
};
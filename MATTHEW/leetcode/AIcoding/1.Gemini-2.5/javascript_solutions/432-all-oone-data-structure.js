class DoublyLinkedListNode {
    constructor(count) {
        this.count = count;
        this.keys = new Set();
        this.prev = null;
        this.next = null;
    }
}

class AllOne {
    constructor() {
        this.keyToCount = new Map();
        this.countToListNode = new Map();

        this.head = new DoublyLinkedListNode(0);
        this.tail = new DoublyLinkedListNode(0);
        this.head.next = this.tail;
        this.tail.prev = this.head;
    }

    _removeNode(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    _insertAfter(prevNode, newNode) {
        newNode.prev = prevNode;
        newNode.next = prevNode.next;
        prevNode.next.prev = newNode;
        prevNode.next = newNode;
    }

    inc(key) {
        const currentCount = this.keyToCount.get(key) || 0;
        const newCount = currentCount + 1;
        this.keyToCount.set(key, newCount);

        if (currentCount > 0) {
            const currentNode = this.countToListNode.get(currentCount);
            currentNode.keys.delete(key);
            if (currentNode.keys.size === 0) {
                this._removeNode(currentNode);
                this.countToListNode.delete(currentCount);
            }
        }

        let newNode = this.countToListNode.get(newCount);
        if (!newNode) {
            newNode = new DoublyLinkedListNode(newCount);
            this.countToListNode.set(newCount, newNode);

            let prevNodeForInsertion;
            if (currentCount === 0) {
                prevNodeForInsertion = this.head;
            } else {
                prevNodeForInsertion = this.countToListNode.get(currentCount);
                if (!prevNodeForInsertion) {
                    prevNodeForInsertion = this.countToListNode.get(newCount - 1) || this.head;
                }
            }
            this._insertAfter(prevNodeForInsertion, newNode);
        }
        newNode.keys.add(key);
    }

    dec(key) {
        const currentCount = this.keyToCount.get(key);
        if (currentCount === undefined) {
            return;
        }

        const newCount = currentCount - 1;

        const currentNode = this.countToListNode.get(currentCount);
        currentNode.keys.delete(key);
        if (currentNode.keys.size === 0) {
            this._removeNode(currentNode);
            this.countToListNode.delete(currentCount);
        }

        if (newCount === 0) {
            this.keyToCount.delete(key);
        } else {
            this.keyToCount.set(key, newCount);
            let newNode = this.countToListNode.get(newCount);
            if (!newNode) {
                newNode = new DoublyLinkedListNode(newCount);
                this.countToListNode.set(newCount, newNode);

                const prevNodeForInsertion = this.countToListNode.get(newCount - 1) || this.head;
                this._insertAfter(prevNodeForInsertion, newNode);
            }
            newNode.keys.add(key);
        }
    }

    getMaxKey() {
        if (this.head.next === this.tail) {
            return "";
        }
        const maxNode = this.tail.prev;
        return maxNode.keys.values().next().value;
    }

    getMinKey() {
        if (this.head.next === this.tail) {
            return "";
        }
        const minNode = this.head.next;
        return minNode.keys.values().next().value;
    }
}
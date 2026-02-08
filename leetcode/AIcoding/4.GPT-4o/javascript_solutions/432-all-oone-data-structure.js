class Node {
    constructor() {
        this.keys = new Set();
        this.prev = null;
        this.next = null;
    }
}

class AllOne {
    constructor() {
        this.keyCount = new Map();
        this.head = new Node();
        this.tail = new Node();
        this.head.next = this.tail;
        this.tail.prev = this.head;
    }

    insertAfter(newNode, prevNode) {
        newNode.next = prevNode.next;
        newNode.prev = prevNode;
        prevNode.next.prev = newNode;
        prevNode.next = newNode;
    }

    removeNode(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }

    inc(key) {
        const count = (this.keyCount.get(key) || 0);
        this.keyCount.set(key, count + 1);
        const newCount = count + 1;
        if (newCount === 1) {
            this.head.next.keys.add(key);
        } else {
            const currentNode = this.findNode(count);
            if (!currentNode) return;
            this.removeNode(currentNode);
            if (!currentNode.keys.size) {
                this.removeNode(currentNode);
            }
            let nextNode = this.findNode(newCount);
            if (!nextNode) {
                nextNode = new Node();
                nextNode.keys.add(key);
                this.insertAfter(nextNode, currentNode);
            } else {
                nextNode.keys.add(key);
            }
        }
    }

    dec(key) {
        const count = this.keyCount.get(key);
        if (count === undefined) return;
        const newCount = count - 1;
        if (newCount === 0) {
            this.keyCount.delete(key);
        } else {
            this.keyCount.set(key, newCount);
        }
        const currentNode = this.findNode(count);
        if (!currentNode) return;
        currentNode.keys.delete(key);
        if (!currentNode.keys.size) {
            this.removeNode(currentNode);
        }
        if (newCount > 0) {
            let prevNode = this.findNode(newCount);
            if (!prevNode) {
                prevNode = new Node();
                this.insertAfter(prevNode, currentNode.prev);
            }
            prevNode.keys.add(key);
        }
    }

    findNode(count) {
        let node = this.head.next;
        while (node !== this.tail) {
            if (node.keys.size > 0 && (this.keyCount.get([...node.keys][0]) === count)) {
                return node;
            }
            node = node.next;
        }
        return null;
    }

    getMaxKey() {
        return this.tail.prev === this.head ? "" : [...this.tail.prev.keys][0];
    }

    getMinKey() {
        return this.head.next === this.tail ? "" : [...this.head.next.keys][0];
    }
}
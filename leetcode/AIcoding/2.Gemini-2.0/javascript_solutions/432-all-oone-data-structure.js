class Node {
    constructor(count) {
        this.count = count;
        this.keys = new Set();
        this.prev = null;
        this.next = null;
    }
}

class AllOne {
    constructor() {
        this.head = new Node(-1);
        this.tail = new Node(-1);
        this.head.next = this.tail;
        this.tail.prev = this.head;
        this.keyMap = new Map();
    }

    inc(key) {
        if (!this.keyMap.has(key)) {
            this.keyMap.set(key, this.head);
        }

        let currNode = this.keyMap.get(key);
        let currCount = currNode.count;

        currNode.keys.delete(key);

        let nextNode = currNode.next;

        if (nextNode.count === currCount + 1) {
            nextNode.keys.add(key);
            this.keyMap.set(key, nextNode);
        } else {
            let newNode = new Node(currCount + 1);
            newNode.keys.add(key);
            this.insertAfter(currNode, newNode);
            this.keyMap.set(key, newNode);
        }

        if (currNode.keys.size === 0 && currNode !== this.head) {
            this.removeNode(currNode);
        }
    }

    dec(key) {
        if (!this.keyMap.has(key)) {
            return;
        }

        let currNode = this.keyMap.get(key);
        let currCount = currNode.count;

        currNode.keys.delete(key);

        if (currCount === 1) {
            this.keyMap.delete(key);
        } else {
            let prevNode = currNode.prev;

            if (prevNode.count === currCount - 1) {
                prevNode.keys.add(key);
                this.keyMap.set(key, prevNode);
            } else {
                let newNode = new Node(currCount - 1);
                newNode.keys.add(key);
                this.insertBefore(currNode, newNode);
                this.keyMap.set(key, newNode);
            }
        }

        if (currNode.keys.size === 0 && currNode !== this.head) {
            this.removeNode(currNode);
        }
    }

    getMaxKey() {
        if (this.tail.prev === this.head) {
            return "";
        }

        let maxNode = this.tail.prev;
        return maxNode.keys.values().next().value;
    }

    getMinKey() {
        if (this.head.next === this.tail) {
            return "";
        }

        let minNode = this.head.next;
        return minNode.keys.values().next().value;
    }

    insertAfter(node, newNode) {
        newNode.prev = node;
        newNode.next = node.next;
        node.next.prev = newNode;
        node.next = newNode;
    }

    insertBefore(node, newNode) {
        newNode.next = node;
        newNode.prev = node.prev;
        node.prev.next = newNode;
        node.prev = newNode;
    }

    removeNode(node) {
        node.prev.next = node.next;
        node.next.prev = node.prev;
    }
}
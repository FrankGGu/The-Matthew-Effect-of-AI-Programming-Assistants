class Node {
    constructor(value) {
        this.value = value;
        this.next = null;
    }
}

class MyLinkedList {
    constructor() {
        this.head = null;
        this.size = 0;
    }

    get(index) {
        if (index < 0 || index >= this.size) return -1;
        let current = this.head;
        for (let i = 0; i < index; i++) {
            current = current.next;
        }
        return current.value;
    }

    addAtHead(value) {
        const newNode = new Node(value);
        newNode.next = this.head;
        this.head = newNode;
        this.size++;
    }

    addAtTail(value) {
        const newNode = new Node(value);
        if (this.size === 0) {
            this.head = newNode;
        } else {
            let current = this.head;
            while (current.next) {
                current = current.next;
            }
            current.next = newNode;
        }
        this.size++;
    }

    addAtIndex(index, value) {
        if (index > this.size) return;
        if (index <= 0) {
            this.addAtHead(value);
        } else {
            const newNode = new Node(value);
            let current = this.head;
            for (let i = 0; i < index - 1; i++) {
                current = current.next;
            }
            newNode.next = current.next;
            current.next = newNode;
            this.size++;
        }
    }

    deleteAtIndex(index) {
        if (index < 0 || index >= this.size) return;
        if (index === 0) {
            this.head = this.head.next;
        } else {
            let current = this.head;
            for (let i = 0; i < index - 1; i++) {
                current = current.next;
            }
            current.next = current.next.next;
        }
        this.size--;
    }
}
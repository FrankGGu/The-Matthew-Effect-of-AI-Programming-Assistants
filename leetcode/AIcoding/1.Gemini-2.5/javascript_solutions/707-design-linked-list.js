class Node {
    constructor(val) {
        this.val = val;
        this.next = null;
    }
}

var MyLinkedList = function() {
    this.head = null;
    this.size = 0;
};

MyLinkedList.prototype.get = function(index) {
    if (index < 0 || index >= this.size) {
        return -1;
    }
    let current = this.head;
    for (let i = 0; i < index; i++) {
        current = current.next;
    }
    return current.val;
};

MyLinkedList.prototype.addAtHead = function(val) {
    const newNode = new Node(val);
    newNode.next = this.head;
    this.head = newNode;
    this.size++;
};

MyLinkedList.prototype.addAtTail = function(val) {
    const newNode = new Node(val);
    if (!this.head) {
        this.head = newNode;
    } else {
        let current = this.head;
        while (current.next) {
            current = current.next;
        }
        current.next = newNode;
    }
    this.size++;
};

MyLinkedList.prototype.addAtIndex = function(index, val) {
    if (index < 0 || index > this.size) {
        return;
    }

    if (index === 0) {
        this.addAtHead(val);
        return;
    }

    if (index === this.size) {
        this.addAtTail(val);
        return;
    }

    const newNode = new Node(val);
    let current = this.head;
    for (let i = 0; i < index - 1; i++) {
        current = current.next;
    }
    newNode.next = current.next;
    current.next = newNode;
    this.size++;
};

MyLinkedList.prototype.deleteAtIndex = function(index) {
    if (index < 0 || index >= this.size) {
        return;
    }

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
};
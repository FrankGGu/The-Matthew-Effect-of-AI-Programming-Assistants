class ListNode {
    constructor(val, next = null) {
        this.val = val;
        this.next = next;
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
        return current.val;
    }

    addAtHead(val) {
        this.head = new ListNode(val, this.head);
        this.size++;
    }

    addAtTail(val) {
        if (!this.head) {
            this.head = new ListNode(val);
        } else {
            let current = this.head;
            while (current.next) {
                current = current.next;
            }
            current.next = new ListNode(val);
        }
        this.size++;
    }

    addAtIndex(index, val) {
        if (index < 0 || index > this.size) return;
        if (index === 0) {
            this.addAtHead(val);
        } else if (index === this.size) {
            this.addAtTail(val);
        } else {
            let current = this.head;
            for (let i = 0; i < index - 1; i++) {
                current = current.next;
            }
            current.next = new ListNode(val, current.next);
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
            current.next = current.next ? current.next.next : null;
        }
        this.size--;
    }
}
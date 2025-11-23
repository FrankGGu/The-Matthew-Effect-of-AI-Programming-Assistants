function reverseEvenLengthGroups(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prev = dummy;
    let length = 0;
    let current = head;

    while (current) {
        length++;
        let nextGroupStart = current;
        for (let i = 0; i < length; i++) {
            if (nextGroupStart) {
                nextGroupStart = nextGroupStart.next;
            }
        }

        if (length % 2 === 0) {
            let next = null;
            let last = current;
            for (let i = 0; i < length; i++) {
                let temp = current.next;
                current.next = next;
                next = current;
                current = temp;
            }
            prev.next = next;
            prev = last;
        } else {
            for (let i = 0; i < length; i++) {
                prev = current;
                current = current.next;
            }
        }

        current = nextGroupStart;
        length = 0;
    }

    return dummy.next;
}

class ListNode {
    constructor(val, next) {
        this.val = val === undefined ? 0 : val;
        this.next = next === undefined ? null : next;
    }
}
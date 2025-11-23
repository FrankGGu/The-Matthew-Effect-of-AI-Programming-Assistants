class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var reverseEvenLengthGroups = function(head) {
    let groupSize = 1;
    let current = head;
    let prevTail = null;
    let newHead = null;

    while (current) {
        let groupStart = current;
        let count = 0;

        while (current && count < groupSize) {
            count++;
            current = current.next;
        }

        if (count % 2 === 0) {
            let reversed = reverseList(groupStart, count);
            if (!newHead) newHead = reversed;
            if (prevTail) prevTail.next = reversed;
            groupStart.next = current;
            prevTail = groupStart;
        } else {
            if (prevTail) prevTail.next = groupStart;
            prevTail = groupStart;
        }

        groupSize++;
    }

    return newHead ? newHead : head;
};

function reverseList(head, count) {
    let prev = null;
    let current = head;
    while (count--) {
        let nextNode = current.next;
        current.next = prev;
        prev = current;
        current = nextNode;
    }
    return prev;
}
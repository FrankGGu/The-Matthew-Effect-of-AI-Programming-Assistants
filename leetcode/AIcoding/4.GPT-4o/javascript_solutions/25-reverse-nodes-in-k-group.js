class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var reverseKGroup = function(head, k) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prevGroupEnd = dummy;

    while (true) {
        let kthNode = prevGroupEnd;
        for (let i = 0; i < k; i++) {
            kthNode = kthNode.next;
            if (!kthNode) return dummy.next;
        }
        let groupStart = prevGroupEnd.next;
        let groupEnd = kthNode;
        let nextGroupStart = groupEnd.next;
        groupEnd.next = null;

        prevGroupEnd.next = reverseList(groupStart);
        groupStart.next = nextGroupStart;
        prevGroupEnd = groupStart;
    }
};

function reverseList(head) {
    let prev = null;
    let curr = head;
    while (curr) {
        let nextTemp = curr.next;
        curr.next = prev;
        prev = curr;
        curr = nextTemp;
    }
    return prev;
}
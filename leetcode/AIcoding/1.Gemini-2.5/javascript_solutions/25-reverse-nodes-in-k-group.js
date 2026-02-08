var reverseKGroup = function(head, k) {
    if (!head || k === 1) {
        return head;
    }

    const dummy = new ListNode(0);
    dummy.next = head;

    let prevGroupTail = dummy;
    let currentGroupHead = head;

    while (currentGroupHead) {
        let kthNode = currentGroupHead;
        let count = 1;
        while (count < k && kthNode) {
            kthNode = kthNode.next;
            count++;
        }

        if (!kthNode) {
            prevGroupTail.next = currentGroupHead;
            break;
        }

        let nextGroupHead = kthNode.next;
        kthNode.next = null;

        let reversedHead = reverseList(currentGroupHead);

        prevGroupTail.next = reversedHead;

        prevGroupTail = currentGroupHead;
        prevGroupTail.next = nextGroupHead;

        currentGroupHead = nextGroupHead;
    }

    return dummy.next;
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
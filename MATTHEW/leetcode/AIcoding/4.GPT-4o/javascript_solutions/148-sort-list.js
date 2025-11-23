class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

function sortList(head) {
    if (!head || !head.next) return head;

    let mid = getMid(head);
    let left = sortList(head);
    let right = sortList(mid);

    return merge(left, right);
}

function getMid(head) {
    let slow = head;
    let fast = head.next;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let mid = slow.next;
    slow.next = null;
    return mid;
}

function merge(left, right) {
    let dummy = new ListNode(0);
    let current = dummy;

    while (left && right) {
        if (left.val < right.val) {
            current.next = left;
            left = left.next;
        } else {
            current.next = right;
            right = right.next;
        }
        current = current.next;
    }

    current.next = left ? left : right;
    return dummy.next;
}
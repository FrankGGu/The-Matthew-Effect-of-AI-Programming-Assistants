var sortList = function(head) {
    if (!head || !head.next) {
        return head;
    }

    let slow = head;
    let fast = head;
    let prev = null;

    while (fast && fast.next) {
        prev = slow;
        slow = slow.next;
        fast = fast.next.next;
    }

    if (prev) {
        prev.next = null;
    }

    let leftHalf = sortList(head);
    let rightHalf = sortList(slow);

    return mergeTwoLists(leftHalf, rightHalf);
};

var mergeTwoLists = function(l1, l2) {
    let dummyHead = new ListNode(0);
    let current = dummyHead;

    while (l1 && l2) {
        if (l1.val <= l2.val) {
            current.next = l1;
            l1 = l1.next;
        } else {
            current.next = l2;
            l2 = l2.next;
        }
        current = current.next;
    }

    if (l1) {
        current.next = l1;
    } else if (l2) {
        current.next = l2;
    }

    return dummyHead.next;
};
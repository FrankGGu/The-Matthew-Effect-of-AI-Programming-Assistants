var reorderList = function(head) {
    if (!head || !head.next) return;

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let head2 = slow.next;
    slow.next = null;

    let prev = null;
    let curr = head2;
    while (curr) {
        let next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }

    head2 = prev;

    let first = head;
    let second = head2;

    while (second) {
        let temp1 = first.next;
        let temp2 = second.next;

        first.next = second;
        second.next = temp1;

        first = temp1;
        second = temp2;
    }
};
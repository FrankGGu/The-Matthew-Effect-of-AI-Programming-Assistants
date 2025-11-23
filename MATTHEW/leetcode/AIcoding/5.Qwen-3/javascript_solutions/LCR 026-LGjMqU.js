function reorderList(head) {
    if (!head || !head.next) return;

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let prev = null;
    let curr = slow;

    while (curr) {
        let nextTemp = curr.next;
        curr.next = prev;
        prev = curr;
        curr = nextTemp;
    }

    let first = head;
    let second = prev;

    while (second.next) {
        let nextTemp1 = first.next;
        let nextTemp2 = second.next;

        first.next = second;
        second.next = nextTemp1;

        first = nextTemp1;
        second = nextTemp2;
    }
}
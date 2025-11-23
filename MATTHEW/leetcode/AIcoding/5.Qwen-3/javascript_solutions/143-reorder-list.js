function reorderList(head) {
    if (!head || !head.next) return;

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let second = slow.next;
    slow.next = null;

    let prev = null;
    let curr = second;

    while (curr) {
        let next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }

    let first = head;
    let secondHead = prev;

    while (secondHead) {
        let nextFirst = first.next;
        let nextSecond = secondHead.next;

        first.next = secondHead;
        secondHead.next = nextFirst;

        first = nextFirst;
        secondHead = nextSecond;
    }
}
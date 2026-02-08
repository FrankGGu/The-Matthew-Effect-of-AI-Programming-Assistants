function mergeInBetween(list1, a, b, list2) {
    let dummy = new ListNode(0);
    dummy.next = list1;
    let prevA = dummy;

    for (let i = 0; i < a; i++) {
        prevA = prevA.next;
    }

    let afterB = prevA;
    for (let i = 0; i <= b - a; i++) {
        afterB = afterB.next;
    }

    prevA.next = list2;

    let tail = list2;
    while (tail.next) {
        tail = tail.next;
    }
    tail.next = afterB;

    return dummy.next;
}
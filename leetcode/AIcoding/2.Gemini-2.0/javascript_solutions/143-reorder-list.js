var reorderList = function(head) {
    if (!head || !head.next) return;

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let secondHalf = slow.next;
    slow.next = null;

    let prev = null;
    let curr = secondHalf;
    while (curr) {
        let next = curr.next;
        curr.next = prev;
        prev = curr;
        curr = next;
    }

    let firstHalf = head;
    secondHalf = prev;

    while (secondHalf) {
        let nextFirst = firstHalf.next;
        let nextSecond = secondHalf.next;

        firstHalf.next = secondHalf;
        secondHalf.next = nextFirst;

        firstHalf = nextFirst;
        secondHalf = nextSecond;
    }
};
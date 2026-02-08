var isPalindrome = function(head) {
    if (!head || !head.next) {
        return true;
    }

    let slow = head;
    let fast = head;
    while (fast.next && fast.next.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let secondHalfHead = reverseList(slow.next);

    let firstHalfCurrent = head;
    let secondHalfCurrent = secondHalfHead;
    let isPal = true;

    while (secondHalfCurrent) {
        if (firstHalfCurrent.val !== secondHalfCurrent.val) {
            isPal = false;
            break;
        }
        firstHalfCurrent = firstHalfCurrent.next;
        secondHalfCurrent = secondHalfCurrent.next;
    }

    return isPal;
};

function reverseList(head) {
    let prev = null;
    let current = head;
    while (current) {
        let nextTemp = current.next;
        current.next = prev;
        prev = current;
        current = nextTemp;
    }
    return prev;
}
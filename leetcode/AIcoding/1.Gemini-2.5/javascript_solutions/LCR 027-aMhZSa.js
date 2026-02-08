var isPalindrome = function(head) {
    if (!head || !head.next) {
        return true;
    }

    let slow = head;
    let fast = head;

    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let secondHalfHead = reverseList(slow);

    let firstHalfPointer = head;
    let secondHalfPointer = secondHalfHead;

    while (secondHalfPointer) {
        if (firstHalfPointer.val !== secondHalfPointer.val) {
            return false;
        }
        firstHalfPointer = firstHalfPointer.next;
        secondHalfPointer = secondHalfPointer.next;
    }

    return true;
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
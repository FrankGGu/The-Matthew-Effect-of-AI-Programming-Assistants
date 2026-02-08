function isPalindrome(head) {
    if (!head) return true;

    let slow = head, fast = head;
    while (fast && fast.next) {
        slow = slow.next;
        fast = fast.next.next;
    }

    let prev = null;
    while (slow) {
        let nextTemp = slow.next;
        slow.next = prev;
        prev = slow;
        slow = nextTemp;
    }

    let left = head, right = prev;
    while (right) {
        if (left.val !== right.val) return false;
        left = left.next;
        right = right.next;
    }

    return true;
}
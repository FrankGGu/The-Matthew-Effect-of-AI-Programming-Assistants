var sortList = function(head) {
    if (!head || !head.next) {
        return head;
    }

    const getMid = (head) => {
        let slow = head;
        let fast = head.next;
        while (fast && fast.next) {
            slow = slow.next;
            fast = fast.next.next;
        }
        return slow;
    }

    const merge = (left, right) => {
        let dummy = { next: null };
        let tail = dummy;

        while (left && right) {
            if (left.val < right.val) {
                tail.next = left;
                left = left.next;
            } else {
                tail.next = right;
                right = right.next;
            }
            tail = tail.next;
        }

        tail.next = left || right;
        return dummy.next;
    }

    const mid = getMid(head);
    const left = head;
    const right = mid.next;
    mid.next = null;

    const sortedLeft = sortList(left);
    const sortedRight = sortList(right);

    return merge(sortedLeft, sortedRight);
};
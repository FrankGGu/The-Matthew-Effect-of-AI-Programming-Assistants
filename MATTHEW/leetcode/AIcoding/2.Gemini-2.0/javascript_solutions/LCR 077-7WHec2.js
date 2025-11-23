var sortList = function(head) {
    if (!head || !head.next) return head;

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

    let mid = getMid(head);
    let left = head;
    let right = mid.next;
    mid.next = null;

    left = sortList(left);
    right = sortList(right);

    return merge(left, right);
};
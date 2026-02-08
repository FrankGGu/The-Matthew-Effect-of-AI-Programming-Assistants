var reverseKGroup = function(head, k) {
    if (!head || k <= 1) return head;

    let dummy = new ListNode(0);
    dummy.next = head;
    let pre = dummy;
    let cur = head;

    while (cur) {
        let tail = pre;
        for (let i = 0; i < k; i++) {
            tail = tail.next;
            if (!tail) return dummy.next;
        }

        let next = tail.next;
        let [newHead, newTail] = reverseList(cur, tail);

        pre.next = newHead;
        newTail.next = next;

        pre = newTail;
        cur = next;
    }

    return dummy.next;

    function reverseList(head, tail) {
        let prev = tail.next;
        let curr = head;

        while (prev !== tail) {
            let next = curr.next;
            curr.next = prev;
            prev = curr;
            curr = next;
        }

        return [tail, head];
    }
};
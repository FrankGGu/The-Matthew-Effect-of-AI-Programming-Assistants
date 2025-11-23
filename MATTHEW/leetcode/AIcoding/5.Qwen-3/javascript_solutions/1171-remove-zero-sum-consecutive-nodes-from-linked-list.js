var removeZeroSumConsecutive = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let map = new Map();
    let sum = 0;
    let current = dummy;
    while (current) {
        sum += current.val;
        if (map.has(sum)) {
            let prev = map.get(sum);
            let temp = prev.next;
            let s = sum;
            while (temp !== current) {
                s += temp.val;
                map.delete(s);
                temp = temp.next;
            }
            prev.next = current.next;
        } else {
            map.set(sum, current);
        }
        current = current.next;
    }
    return dummy.next;
};
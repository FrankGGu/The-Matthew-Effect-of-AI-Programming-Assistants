var removeZeroSumSublists = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let map = new Map();
    let sum = 0;
    let curr = dummy;

    while (curr) {
        sum += curr.val;
        if (map.has(sum)) {
            let prev = map.get(sum).next;
            let tempSum = sum;
            while (prev !== curr) {
                tempSum += prev.val;
                map.delete(tempSum);
                prev = prev.next;
            }
            map.get(sum).next = curr.next;
        } else {
            map.set(sum, curr);
        }
        curr = curr.next;
    }

    return dummy.next;
};
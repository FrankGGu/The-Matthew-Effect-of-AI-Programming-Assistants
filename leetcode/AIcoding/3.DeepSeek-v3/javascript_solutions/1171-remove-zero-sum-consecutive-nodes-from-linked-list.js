var removeZeroSumSublists = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;
    let prefixSum = 0;
    let map = new Map();
    map.set(0, dummy);
    let current = head;

    while (current) {
        prefixSum += current.val;
        if (map.has(prefixSum)) {
            let toRemove = map.get(prefixSum).next;
            let tempSum = prefixSum + toRemove.val;
            while (toRemove !== current) {
                map.delete(tempSum);
                toRemove = toRemove.next;
                tempSum += toRemove.val;
            }
            map.get(prefixSum).next = current.next;
        } else {
            map.set(prefixSum, current);
        }
        current = current.next;
    }

    return dummy.next;
};
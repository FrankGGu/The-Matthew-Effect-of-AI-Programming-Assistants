var removeZeroSumSublists = function(head) {
    let dummy = new ListNode(0);
    dummy.next = head;

    let prefixSumMap = new Map();
    prefixSumMap.set(0, dummy);

    let currentSum = 0;
    let current = dummy;

    while (current !== null) {
        currentSum += current.val;

        if (prefixSumMap.has(currentSum)) {
            let prev = prefixSumMap.get(currentSum);

            let nodeToRemoveFromMap = prev.next;
            let sumAtNodeToRemove = currentSum;

            while (nodeToRemoveFromMap !== current.next) {
                sumAtNodeToRemove += nodeToRemoveFromMap.val;
                if (sumAtNodeToRemove !== 0) { 
                    prefixSumMap.delete(sumAtNodeToRemove);
                }
                nodeToRemoveFromMap = nodeToRemoveFromMap.next;
            }

            prev.next = current.next;

            current = prev;

        } else {
            prefixSumMap.set(currentSum, current);
        }

        current = current.next;
    }

    return dummy.next;
};
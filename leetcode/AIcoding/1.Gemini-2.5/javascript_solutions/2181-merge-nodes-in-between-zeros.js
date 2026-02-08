var mergeNodes = function(head) {
    let newHeadDummy = new ListNode(0);
    let currentNewNode = newHeadDummy;
    let currentOriginal = head;

    currentOriginal = currentOriginal.next;

    while (currentOriginal !== null) {
        let currentSum = 0;
        while (currentOriginal.val !== 0) {
            currentSum += currentOriginal.val;
            currentOriginal = currentOriginal.next;
        }

        currentNewNode.next = new ListNode(currentSum);
        currentNewNode = currentNewNode.next;

        currentOriginal = currentOriginal.next;
    }

    return newHeadDummy.next;
};
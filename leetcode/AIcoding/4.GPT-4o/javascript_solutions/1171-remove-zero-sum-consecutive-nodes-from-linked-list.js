class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var removeZeroSumSublists = function(head) {
    const dummy = new ListNode(0);
    dummy.next = head;
    const map = new Map();
    let prefixSum = 0;
    let curr = dummy;

    while (curr) {
        prefixSum += curr.val;
        if (map.has(prefixSum)) {
            let prev = map.get(prefixSum);
            let temp = prev.next;
            let tempSum = prefixSum;
            while (temp !== curr) {
                tempSum += temp.val;
                map.delete(tempSum);
                temp = temp.next;
            }
            prev.next = curr.next;
        } else {
            map.set(prefixSum, curr);
        }
        curr = curr.next;
    }

    return dummy.next;
};
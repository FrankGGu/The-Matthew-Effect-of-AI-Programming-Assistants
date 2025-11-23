class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var doubleIt = function(head) {
    let carry = 0;
    let current = head;
    let reversed = null;

    while (current) {
        let newNode = new ListNode(current.val * 2 + carry);
        carry = Math.floor(newNode.val / 10);
        newNode.val %= 10;
        newNode.next = reversed;
        reversed = newNode;
        current = current.next;
    }

    if (carry > 0) {
        let newNode = new ListNode(carry);
        newNode.next = reversed;
        reversed = newNode;
    }

    let result = null;
    while (reversed) {
        let newNode = new ListNode(reversed.val);
        newNode.next = result;
        result = newNode;
        reversed = reversed.next;
    }

    return result;
};
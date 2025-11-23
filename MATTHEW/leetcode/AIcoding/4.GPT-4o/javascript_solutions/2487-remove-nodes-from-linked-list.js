class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var removeNodes = function(head) {
    let dummy = new ListNode(0);
    let stack = [];

    while (head) {
        while (stack.length && stack[stack.length - 1].val < head.val) {
            stack.pop();
        }
        stack.push(head);
        head = head.next;
    }

    for (let i = stack.length - 1; i >= 0; i--) {
        stack[i].next = dummy.next;
        dummy.next = stack[i];
    }

    return dummy.next;
};
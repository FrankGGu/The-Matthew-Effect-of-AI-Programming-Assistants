class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

function insertGCD(head) {
    if (!head) return null;

    let current = head;
    while (current && current.next) {
        const gcdValue = gcd(current.val, current.next.val);
        const newNode = new ListNode(gcdValue, current.next);
        current.next = newNode;
        current = newNode.next;
    }

    return head;
}

function gcd(a, b) {
    while (b) {
        [a, b] = [b, a % b];
    }
    return a;
}
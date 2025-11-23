var insertGreatestCommonDivisors = function(head) {
    if (!head || !head.next) return head;

    let current = head;
    while (current && current.next) {
        const nextNode = current.next;
        const gcdValue = gcd(current.val, nextNode.val);
        const newNode = new ListNode(gcdValue);

        current.next = newNode;
        newNode.next = nextNode;

        current = nextNode;
    }
    return head;
};

function gcd(a, b) {
    while (b !== 0) {
        let temp = b;
        b = a % b;
        a = temp;
    }
    return a;
}
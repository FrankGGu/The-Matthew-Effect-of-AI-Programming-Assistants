var insertGreatestCommonDivisors = function(head) {
    if (!head || !head.next) {
        return head;
    }

    const gcd = (a, b) => {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    };

    let current = head;

    while (current && current.next) {
        let val1 = current.val;
        let val2 = current.next.val;

        let commonDivisor = gcd(val1, val2);

        let newNode = new ListNode(commonDivisor);

        newNode.next = current.next;
        current.next = newNode;

        current = current.next.next;
    }

    return head;
};
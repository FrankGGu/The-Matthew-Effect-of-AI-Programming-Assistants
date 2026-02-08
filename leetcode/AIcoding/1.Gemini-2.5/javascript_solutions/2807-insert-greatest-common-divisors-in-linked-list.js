function insertGreatestCommonDivisors(head) {
    if (!head || !head.next) {
        return head;
    }

    function gcd(a, b) {
        while (b !== 0) {
            let temp = b;
            b = a % b;
            a = temp;
        }
        return a;
    }

    let current = head;

    while (current.next !== null) {
        let node1 = current;
        let node2 = current.next;

        let commonDivisor = gcd(node1.val, node2.val);

        let newNode = new ListNode(commonDivisor);

        newNode.next = node2;
        node1.next = newNode;

        current = node2;
    }

    return head;
}
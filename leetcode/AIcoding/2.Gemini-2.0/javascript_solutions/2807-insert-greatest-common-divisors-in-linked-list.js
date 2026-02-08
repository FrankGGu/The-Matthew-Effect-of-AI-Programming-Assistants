var insertGreatestCommonDivisors = function(head) {
    let curr = head;
    while (curr && curr.next) {
        let gcdVal = gcd(curr.val, curr.next.val);
        let newNode = new ListNode(gcdVal);
        newNode.next = curr.next;
        curr.next = newNode;
        curr = newNode.next;
    }
    return head;

    function gcd(a, b) {
        if (b === 0) {
            return a;
        }
        return gcd(b, a % b);
    }
};
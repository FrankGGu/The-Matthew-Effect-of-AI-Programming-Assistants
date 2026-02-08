class Node {
    constructor(val, next = null, random = null) {
        this.val = val;
        this.next = next;
        this.random = random;
    }
}

var copyRandomList = function(head) {
    if (!head) return null;

    let map = new Map();
    let current = head;

    while (current) {
        map.set(current, new Node(current.val));
        current = current.next;
    }

    current = head;

    while (current) {
        if (current.next) {
            map.get(current).next = map.get(current.next);
        }
        if (current.random) {
            map.get(current).random = map.get(current.random);
        }
        current = current.next;
    }

    return map.get(head);
};
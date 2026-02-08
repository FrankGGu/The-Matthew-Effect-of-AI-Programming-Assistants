var copyRandomList = function(head) {
    if (!head) return null;

    const map = new Map();
    let current = head;

    while (current) {
        map.set(current, new Node(current.val));
        current = current.next;
    }

    current = head;
    while (current) {
        map.get(current).next = map.get(current.next) || null;
        map.get(current).random = map.get(current.random) || null;
        current = current.next;
    }

    return map.get(head);
};
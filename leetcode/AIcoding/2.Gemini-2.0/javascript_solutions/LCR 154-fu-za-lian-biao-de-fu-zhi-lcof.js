var copyRandomList = function(head) {
    if (!head) return null;

    let map = new Map();
    let curr = head;

    while (curr) {
        map.set(curr, new Node(curr.val));
        curr = curr.next;
    }

    curr = head;
    while (curr) {
        map.get(curr).next = map.get(curr.next) || null;
        map.get(curr).random = map.get(curr.random) || null;
        curr = curr.next;
    }

    return map.get(head);
};
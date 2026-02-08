class ListNode {
    constructor(val = 0, next = null) {
        this.val = val;
        this.next = next;
    }
}

var mergeKLists = function(lists) {
    if (!lists.length) return null;

    const minHeap = new MinPriorityQueue({ priority: x => x.val });

    for (const list of lists) {
        if (list) minHeap.enqueue(list);
    }

    const dummy = new ListNode(0);
    let current = dummy;

    while (minHeap.size() > 0) {
        const node = minHeap.dequeue().element;
        current.next = node;
        current = current.next;
        if (node.next) minHeap.enqueue(node.next);
    }

    return dummy.next;
};
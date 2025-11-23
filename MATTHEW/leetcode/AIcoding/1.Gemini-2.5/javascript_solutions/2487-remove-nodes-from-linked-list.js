var removeNodes = function(head) {
    if (!head) {
        return null;
    }

    let nextProcessed = removeNodes(head.next);

    if (!nextProcessed) {
        return head;
    }

    if (head.val < nextProcessed.val) {
        return nextProcessed;
    } else {
        head.next = nextProcessed;
        return head;
    }
};
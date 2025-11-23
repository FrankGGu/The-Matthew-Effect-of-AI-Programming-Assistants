var mergeInBetween = function(list1, a, b, list2) {
    let curr = list1;
    let nodeBeforeA = null;
    let nodeB = null;
    let index = 0;

    while (curr !== null) {
        if (index === a - 1) {
            nodeBeforeA = curr;
        }
        if (index === b) {
            nodeB = curr;
            break; 
        }
        curr = curr.next;
        index++;
    }

    let tail2 = list2;
    while (tail2.next !== null) {
        tail2 = tail2.next;
    }

    if (nodeBeforeA !== null) {
        nodeBeforeA.next = list2;
    } else {
        list1 = list2;
    }

    tail2.next = nodeB.next;

    return list1;
};
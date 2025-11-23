var mergeInBetween = function(list1, a, b, list2) {
    let prevA = null;
    let nodeB = null;
    let current = list1;
    let index = 0;

    while (current !== null) {
        if (index === a - 1) {
            prevA = current;
        }
        if (index === b) {
            nodeB = current.next;
            break;
        }
        current = current.next;
        index++;
    }

    prevA.next = list2;

    let tailList2 = list2;
    while (tailList2.next !== null) {
        tailList2 = tailList2.next;
    }

    tailList2.next = nodeB;

    return list1;
};
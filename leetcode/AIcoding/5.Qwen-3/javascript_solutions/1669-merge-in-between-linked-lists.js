function mergeInBetween(list1, a, b, list2) {
    let prev = null;
    let curr = list1;
    let i = 0;

    while (i < a) {
        prev = curr;
        curr = curr.next;
        i++;
    }

    while (i <= b) {
        curr = curr.next;
        i++;
    }

    prev.next = list2;

    while (list2.next) {
        list2 = list2.next;
    }

    list2.next = curr;

    return list1;
}
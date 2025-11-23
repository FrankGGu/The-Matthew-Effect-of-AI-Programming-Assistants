function splitListToParts(head, k) {
    let length = 0;
    let current = head;
    while (current) {
        length++;
        current = current.next;
    }

    const result = [];
    let count = Math.floor(length / k);
    let remainder = length % k;
    let i = 0;

    current = head;
    while (current) {
        result.push(current);
        let j = 1;
        while (j < count + (i < remainder ? 1 : 0)) {
            current = current.next;
            j++;
        }
        const next = current.next;
        current.next = null;
        current = next;
        i++;
    }

    while (result.length < k) {
        result.push(null);
    }

    return result;
}
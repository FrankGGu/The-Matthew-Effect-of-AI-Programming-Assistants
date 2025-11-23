var splitListToParts = function(head, k) {
    let current = head;
    let length = 0;
    while (current) {
        length++;
        current = current.next;
    }

    const baseSize = Math.floor(length / k);
    let extraElements = length % k;

    const result = new Array(k).fill(null);
    current = head;

    for (let i = 0; i < k; i++) {
        if (!current) {
            break; 
        }

        result[i] = current;
        let currentPartSize = baseSize + (extraElements > 0 ? 1 : 0);
        if (extraElements > 0) {
            extraElements--;
        }

        let prev = null;
        for (let j = 0; j < currentPartSize; j++) {
            prev = current;
            current = current.next;
        }

        if (prev) {
            prev.next = null;
        }
    }

    return result;
};
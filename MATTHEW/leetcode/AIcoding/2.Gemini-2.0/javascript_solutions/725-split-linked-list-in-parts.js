var splitListToParts = function(head, k) {
    let len = 0;
    let curr = head;
    while (curr) {
        len++;
        curr = curr.next;
    }

    let baseSize = Math.floor(len / k);
    let extra = len % k;

    let result = [];
    curr = head;
    for (let i = 0; i < k; i++) {
        let partSize = baseSize + (i < extra ? 1 : 0);
        if (partSize === 0) {
            result.push(null);
            continue;
        }

        result.push(curr);
        let prev = null;
        for (let j = 0; j < partSize; j++) {
            prev = curr;
            curr = curr.next;
        }
        prev.next = null;
    }

    return result;
};
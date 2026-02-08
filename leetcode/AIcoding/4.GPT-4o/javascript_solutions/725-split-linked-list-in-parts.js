var splitListToParts = function(root, k) {
    let len = 0;
    let current = root;

    while (current) {
        len++;
        current = current.next;
    }

    const partSize = Math.floor(len / k);
    const extraParts = len % k;
    const result = [];

    current = root;

    for (let i = 0; i < k; i++) {
        let head = current;
        let size = partSize + (i < extraParts ? 1 : 0);

        for (let j = 0; j < size - 1; j++) {
            if (current) current = current.next;
        }

        if (current) {
            const next = current.next;
            current.next = null;
            current = next;
        }

        result.push(head);
    }

    return result;
};
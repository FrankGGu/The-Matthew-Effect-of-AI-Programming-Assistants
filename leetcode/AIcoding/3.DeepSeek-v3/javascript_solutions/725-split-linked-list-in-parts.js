var splitListToParts = function(root, k) {
    let length = 0;
    let current = root;
    while (current) {
        length++;
        current = current.next;
    }

    const partSize = Math.floor(length / k);
    let extra = length % k;

    const result = [];
    current = root;

    for (let i = 0; i < k; i++) {
        let partLength = partSize + (extra > 0 ? 1 : 0);
        extra--;

        if (partLength === 0) {
            result.push(null);
            continue;
        }

        let head = current;
        for (let j = 0; j < partLength - 1; j++) {
            if (current) current = current.next;
        }

        if (current) {
            let next = current.next;
            current.next = null;
            current = next;
        }

        result.push(head);
    }

    return result;
};
var numComponents = function(head, G) {
    const setG = new Set(G);
    let count = 0;
    let inComponent = false;

    while (head) {
        if (setG.has(head.val)) {
            if (!inComponent) {
                count++;
                inComponent = true;
            }
        } else {
            inComponent = false;
        }
        head = head.next;
    }

    return count;
};
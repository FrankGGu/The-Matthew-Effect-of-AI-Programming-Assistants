var numComponents = function(head, G) {
    const gSet = new Set(G);
    let components = 0;
    let current = head;
    let inComponent = false;

    while (current !== null) {
        if (gSet.has(current.val)) {
            if (!inComponent) {
                components++;
                inComponent = true;
            }
        } else {
            inComponent = false;
        }
        current = current.next;
    }

    return components;
};
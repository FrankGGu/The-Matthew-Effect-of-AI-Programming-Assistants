var numComponents = function(head, nums) {
    const numSet = new Set(nums);
    let components = 0;
    let inComponent = false;

    while (head !== null) {
        if (numSet.has(head.val)) {
            if (!inComponent) {
                components++;
                inComponent = true;
            }
        } else {
            inComponent = false;
        }
        head = head.next;
    }

    return components;
};
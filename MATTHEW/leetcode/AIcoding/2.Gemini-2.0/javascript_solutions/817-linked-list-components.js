var numComponents = function(head, nums) {
    let set = new Set(nums);
    let count = 0;
    let inComponent = false;

    while (head) {
        if (set.has(head.val)) {
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
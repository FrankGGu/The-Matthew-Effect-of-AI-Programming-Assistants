var timeTaken = function(head, nums) {
    let time = 0;
    let current = head;
    let index = 0;
    const numsSet = new Set(nums);

    while (current !== null) {
        if (numsSet.has(current.val)) {
            time++;
            index++;
            if (index === nums.length) break;
        } else {
            time++;
        }
        current = current.next;
    }

    return time;
};
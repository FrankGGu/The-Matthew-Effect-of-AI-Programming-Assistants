var nodesBetweenCriticalPoints = function(head) {
    if (!head || !head.next || !head.next.next) return [-1, -1];

    let prev = head;
    let curr = head.next;
    let next = curr.next;
    let first = -1, last = -1;
    let minDist = Infinity;
    let positions = [];
    let index = 1;

    while (next) {
        if ((curr.val > prev.val && curr.val > next.val) || 
            (curr.val < prev.val && curr.val < next.val)) {
            if (first === -1) {
                first = index;
            } else {
                minDist = Math.min(minDist, index - last);
            }
            last = index;
            positions.push(index);
        }
        prev = curr;
        curr = next;
        next = next.next;
        index++;
    }

    if (positions.length < 2) return [-1, -1];

    let maxDist = positions[positions.length - 1] - positions[0];
    return [minDist, maxDist];
};
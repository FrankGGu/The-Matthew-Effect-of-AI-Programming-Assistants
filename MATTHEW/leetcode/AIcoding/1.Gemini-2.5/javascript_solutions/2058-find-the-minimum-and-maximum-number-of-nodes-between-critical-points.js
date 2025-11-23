var nodesBetweenCriticalPoints = function(head) {
    if (!head || !head.next || !head.next.next) {
        return [-1, -1];
    }

    let criticalPoints = [];
    let prev = head;
    let curr = head.next;
    let idx = 1;

    while (curr.next !== null) {
        let next = curr.next;

        const isLocalMaximum = prev.val < curr.val && curr.val > next.val;
        const isLocalMinimum = prev.val > curr.val && curr.val < next.val;

        if (isLocalMaximum || isLocalMinimum) {
            criticalPoints.push(idx);
        }

        prev = curr;
        curr = next;
        idx++;
    }

    if (criticalPoints.length < 2) {
        return [-1, -1];
    }

    let minDistance = Infinity;
    let maxDistance = criticalPoints[criticalPoints.length - 1] - criticalPoints[0];

    for (let i = 1; i < criticalPoints.length; i++) {
        minDistance = Math.min(minDistance, criticalPoints[i] - criticalPoints[i - 1]);
    }

    return [minDistance, maxDistance];
};
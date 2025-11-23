var nodesBetweenCriticalPoints = function(head) {
    let criticalPoints = [];
    let index = 0;
    let prevValue = null;
    let currValue = head.val;
    let nextValue = head.next ? head.next.val : null;

    while (head) {
        if (prevValue !== null && nextValue !== null) {
            if ((currValue > prevValue && currValue > nextValue) || (currValue < prevValue && currValue < nextValue)) {
                criticalPoints.push(index);
            }
        }
        prevValue = currValue;
        head = head.next;
        currValue = head ? head.val : null;
        nextValue = head && head.next ? head.next.val : null;
        index++;
    }

    if (criticalPoints.length < 2) return [-1, -1];

    let minDistance = Infinity;
    for (let i = 1; i < criticalPoints.length; i++) {
        minDistance = Math.min(minDistance, criticalPoints[i] - criticalPoints[i - 1]);
    }

    return [minDistance, criticalPoints[criticalPoints.length - 1] - criticalPoints[0]];
};
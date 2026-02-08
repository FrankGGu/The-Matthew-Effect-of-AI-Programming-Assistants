var nodesBetweenCriticalPoints = function(head) {
    let criticalPoints = [];
    let prev = head;
    let curr = head.next;
    let i = 1;

    while (curr && curr.next) {
        if ((curr.val > prev.val && curr.val > curr.next.val) ||
            (curr.val < prev.val && curr.val < curr.next.val)) {
            criticalPoints.push(i);
        }
        prev = curr;
        curr = curr.next;
        i++;
    }

    if (criticalPoints.length < 2) {
        return [-1, -1];
    }

    let minDistance = Infinity;
    for (let i = 1; i < criticalPoints.length; i++) {
        minDistance = Math.min(minDistance, criticalPoints[i] - criticalPoints[i - 1]);
    }

    let maxDistance = criticalPoints[criticalPoints.length - 1] - criticalPoints[0];

    return [minDistance, maxDistance];
};
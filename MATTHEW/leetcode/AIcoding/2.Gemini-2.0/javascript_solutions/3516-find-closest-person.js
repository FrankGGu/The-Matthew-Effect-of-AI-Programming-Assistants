var findClosest = function(a, x) {
    let closest = -1;
    let minDiff = Infinity;

    for (let i = 0; i < a.length; i++) {
        let diff = Math.abs(a[i] - x);
        if (diff < minDiff) {
            minDiff = diff;
            closest = a[i];
        } else if (diff === minDiff && a[i] < closest) {
            closest = a[i];
        }
    }

    return closest;
};
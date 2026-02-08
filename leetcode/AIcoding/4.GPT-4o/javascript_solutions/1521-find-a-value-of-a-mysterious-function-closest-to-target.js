var closestToTarget = function(arr, target) {
    let closest = Infinity;
    const n = arr.length;

    for (let i = 0; i < n; i++) {
        let curr = arr[i];
        closest = Math.abs(curr - target) < Math.abs(closest - target) ? curr : closest;
        for (let j = i + 1; j < n; j++) {
            curr &= arr[j];
            closest = Math.abs(curr - target) < Math.abs(closest - target) ? curr : closest;
            if (curr < target) break;
        }
    }

    return closest;
};
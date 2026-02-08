function closestToTarget(arr, target) {
    let minDiff = Infinity;
    let set = new Set();
    for (let num of arr) {
        let newSet = new Set();
        newSet.add(num);
        for (let val of set) {
            newSet.add(val & num);
        }
        set = newSet;
        for (let val of set) {
            minDiff = Math.min(minDiff, Math.abs(val - target));
        }
    }
    return minDiff;
}
var minIncrementsForTargetMultiples = function(arr, target) {
    let totalIncrements = 0;
    for (let i = 0; i < arr.length; i++) {
        const num = arr[i];
        if (num % target !== 0) {
            totalIncrements += (target - (num % target));
        }
    }
    return totalIncrements;
};
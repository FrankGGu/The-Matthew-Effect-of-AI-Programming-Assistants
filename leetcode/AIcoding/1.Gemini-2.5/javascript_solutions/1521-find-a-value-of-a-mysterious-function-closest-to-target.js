var closestToTarget = function(arr, target) {
    let minDiff = Infinity;
    let currentValues = new Set(); // Stores all f(j, i-1) for j <= i-1

    for (let i = 0; i < arr.length; i++) {
        let nextValues = new Set();

        // f(i, i)
        nextValues.add(arr[i]);

        // f(j, i) for j < i
        for (let val of currentValues) {
            nextValues.add(val & arr[i]);
        }

        currentValues = nextValues;

        for (let val of currentValues) {
            minDiff = Math.min(minDiff, Math.abs(val - target));
            if (minDiff === 0) {
                return 0;
            }
        }
    }

    return minDiff;
};
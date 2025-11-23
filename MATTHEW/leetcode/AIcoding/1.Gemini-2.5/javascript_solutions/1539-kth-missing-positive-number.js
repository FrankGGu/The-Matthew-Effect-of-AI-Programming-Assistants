var findKthPositive = function(arr, k) {
    let missingCount = 0;
    let currentPositive = 1;
    let arrIndex = 0;

    while (true) {
        if (arrIndex < arr.length && arr[arrIndex] === currentPositive) {
            arrIndex++;
        } else {
            missingCount++;
            if (missingCount === k) {
                return currentPositive;
            }
        }
        currentPositive++;
    }
};
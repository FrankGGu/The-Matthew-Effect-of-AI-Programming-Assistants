var maxTurbulenceSize = function(arr) {
    let n = arr.length;
    if (n < 2) return n;

    let maxLength = 1;
    let currentLength = 1;
    let previousComparison = 0; // 0: initial, 1: >, -1: <

    for (let i = 1; i < n; i++) {
        if (arr[i] > arr[i - 1]) {
            if (previousComparison != 1) {
                currentLength++;
                maxLength = Math.max(maxLength, currentLength);
                previousComparison = 1;
            } else {
                currentLength = 2;
                previousComparison = 1;
            }
        } else if (arr[i] < arr[i - 1]) {
            if (previousComparison != -1) {
                currentLength++;
                maxLength = Math.max(maxLength, currentLength);
                previousComparison = -1;
            } else {
                currentLength = 2;
                previousComparison = -1;
            }
        } else {
            currentLength = 1;
            previousComparison = 0;
        }
    }

    return maxLength;
};
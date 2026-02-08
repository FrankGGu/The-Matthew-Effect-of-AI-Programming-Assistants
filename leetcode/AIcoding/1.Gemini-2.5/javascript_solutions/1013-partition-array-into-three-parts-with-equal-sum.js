var canThreePartsEqualSum = function(arr) {
    let totalSum = 0;
    for (let i = 0; i < arr.length; i++) {
        totalSum += arr[i];
    }

    if (totalSum % 3 !== 0) {
        return false;
    }

    const targetSum = totalSum / 3;
    let partsFound = 0;
    let currentSum = 0;

    for (let i = 0; i < arr.length; i++) {
        currentSum += arr[i];
        if (currentSum === targetSum) {
            partsFound++;
            currentSum = 0;
            // If we have found two parts, and there are still elements remaining
            // for a third non-empty part, then we can partition.
            // The sum of the remaining elements will automatically be targetSum
            // because totalSum is divisible by 3.
            if (partsFound === 2 && i < arr.length - 1) {
                return true;
            }
        }
    }

    return false;
};
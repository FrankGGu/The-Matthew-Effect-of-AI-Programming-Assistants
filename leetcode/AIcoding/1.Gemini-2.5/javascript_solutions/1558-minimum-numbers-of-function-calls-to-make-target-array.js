var minOperations = function(nums) {
    let numIncrements = 0;
    let numDoubles = 0;

    // Create a mutable copy of the array
    let currentNums = [...nums];

    while (true) {
        let allZeros = true;
        let hasOdd = false;

        // First, check the current state of the array
        for (let i = 0; i < currentNums.length; i++) {
            if (currentNums[i] !== 0) {
                allZeros = false;
            }
            if (currentNums[i] % 2 !== 0) {
                hasOdd = true;
            }
        }

        // If all elements are zero, we have reached the base state, so break.
        if (allZeros) {
            break;
        }

        // If there are any odd numbers, we must perform increment operations on them.
        // In reverse, this means decrementing them by 1.
        if (hasOdd) {
            for (let i = 0; i < currentNums.length; i++) {
                if (currentNums[i] % 2 !== 0) {
                    currentNums[i]--;
                    numIncrements++;
                }
            }
        } else {
            // If all non-zero numbers are even (and not all numbers are zero),
            // we must perform a double operation (in reverse, divide all by 2).
            for (let i = 0; i < currentNums.length; i++) {
                currentNums[i] /= 2;
            }
            numDoubles++;
        }
    }

    return numIncrements + numDoubles;
};
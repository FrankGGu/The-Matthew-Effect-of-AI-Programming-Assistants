var findStableArrays = function(n, k) {
    if (k > Math.floor(n / 2)) {
        return [];
    }

    const result = [];

    function generateArrays(currentArray, remainingZeros, remainingOnes) {
        if (remainingZeros === 0 && remainingOnes === 0) {
            result.push([...currentArray]);
            return;
        }

        if (remainingZeros > 0) {
            const lastElement = currentArray.length > 0 ? currentArray[currentArray.length - 1] : -1;
            if (lastElement !== 0) {
                 currentArray.push(0);
                generateArrays(currentArray, remainingZeros - 1, remainingOnes);
                currentArray.pop();
            }

        }

        if (remainingOnes > 0) {
            if (currentArray.length === 0 || currentArray[currentArray.length - 1] !== 1) {
                currentArray.push(1);
                generateArrays(currentArray, remainingZeros, remainingOnes - 1);
                currentArray.pop();
            }

        }
    }

    generateArrays([], k, n - k);

    return result;
};
function longestEvenOddSubarray(arr, threshold) {
    let maxLength = 0;
    let currentLength = 0;
    let lastWasEven = null;

    for (let num of arr) {
        if (num > threshold) {
            currentLength = 0;
            lastWasEven = null;
            continue;
        }

        const isEven = num % 2 === 0;

        if (lastWasEven === null || isEven !== lastWasEven) {
            currentLength += 1;
            lastWasEven = isEven;
        } else {
            currentLength = 1;
            lastWasEven = isEven;
        }

        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
}
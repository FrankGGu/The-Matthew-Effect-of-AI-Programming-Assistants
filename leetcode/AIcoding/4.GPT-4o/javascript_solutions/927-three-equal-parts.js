var threeEqualParts = function(arr) {
    let totalOnes = arr.reduce((sum, bit) => sum + bit, 0);

    if (totalOnes === 0) return [0, 2];
    if (totalOnes % 3 !== 0) return [-1, -1];

    let onesPerPart = totalOnes / 3;
    let first = 0, second = 0, third = 0;
    let count = 0;

    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === 1) {
            count++;
            if (count === 1) first = i;
            else if (count === onesPerPart + 1) second = i;
            else if (count === 2 * onesPerPart + 1) third = i;
        }
    }

    while (third < arr.length && arr[first] === arr[second] && arr[second] === arr[third]) {
        first++;
        second++;
        third++;
    }

    return third === arr.length ? [first - 1, second] : [-1, -1];
};
var threeEqualParts = function(arr) {
    let ones = 0;
    for (let num of arr) {
        if (num === 1) {
            ones++;
        }
    }

    if (ones % 3 !== 0) {
        return [-1, -1];
    }

    if (ones === 0) {
        return [0, arr.length - 1];
    }

    let targetOnes = ones / 3;
    let firstGroupStart = -1;
    let secondGroupStart = -1;
    let thirdGroupStart = -1;

    let currentOnes = 0;
    for (let i = 0; i < arr.length; i++) {
        if (arr[i] === 1) {
            currentOnes++;
            if (currentOnes === 1 && firstGroupStart === -1) {
                firstGroupStart = i;
            }
            if (currentOnes === targetOnes + 1 && secondGroupStart === -1) {
                secondGroupStart = i;
            }
            if (currentOnes === 2 * targetOnes + 1 && thirdGroupStart === -1) {
                thirdGroupStart = i;
            }
        }
    }

    let len = arr.length - thirdGroupStart;

    if (firstGroupStart + len <= secondGroupStart && secondGroupStart + len <= thirdGroupStart) {
        let i = 0;
        while (thirdGroupStart + i < arr.length) {
            if (arr[firstGroupStart + i] !== arr[secondGroupStart + i] || arr[firstGroupStart + i] !== arr[thirdGroupStart + i]) {
                return [-1, -1];
            }
            i++;
        }
        return [firstGroupStart + len - 1, secondGroupStart + len];
    }

    return [-1, -1];
};
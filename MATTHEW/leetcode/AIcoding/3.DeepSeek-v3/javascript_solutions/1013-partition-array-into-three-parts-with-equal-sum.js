var canThreePartsEqualSum = function(arr) {
    const totalSum = arr.reduce((a, b) => a + b, 0);
    if (totalSum % 3 !== 0) return false;
    const target = totalSum / 3;
    let sum = 0;
    let count = 0;

    for (let i = 0; i < arr.length; i++) {
        sum += arr[i];
        if (sum === target) {
            count++;
            sum = 0;
        }
        if (count === 3) {
            return true;
        }
    }

    return false;
};
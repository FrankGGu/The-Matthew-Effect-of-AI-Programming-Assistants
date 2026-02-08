var canThreePartsEqualSum = function(arr) {
    let sum = arr.reduce((a, b) => a + b, 0);
    if (sum % 3 !== 0) return false;

    let target = sum / 3;
    let currentSum = 0;
    let count = 0;

    for (let i = 0; i < arr.length; i++) {
        currentSum += arr[i];
        if (currentSum === target) {
            count++;
            currentSum = 0;
        }
    }

    return count >= 3;
};
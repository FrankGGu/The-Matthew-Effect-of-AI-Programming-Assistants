function differenceOfSum(num) {
    const digits = String(num).split('').map(Number);
    let totalSum = 0;

    for (let i = 0; i < digits.length; i++) {
        for (let j = 0; j < digits.length; j++) {
            totalSum += Math.abs(digits[i] - digits[j]);
        }
    }

    return totalSum;
}
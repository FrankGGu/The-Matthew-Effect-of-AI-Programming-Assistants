function canThreePartsEqualSum(A) {
    const totalSum = A.reduce((acc, num) => acc + num, 0);
    if (totalSum % 3 !== 0) return false;

    const target = totalSum / 3;
    let currentSum = 0, partsFound = 0;

    for (let num of A) {
        currentSum += num;
        if (currentSum === target) {
            partsFound++;
            currentSum = 0;
        }
    }

    return partsFound >= 3;
}
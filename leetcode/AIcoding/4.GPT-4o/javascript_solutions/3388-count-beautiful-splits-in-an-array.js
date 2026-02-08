function beautifulSplits(array) {
    let count = 0;
    let totalSum = array.reduce((a, b) => a + b, 0);
    let leftSum = 0;

    for (let i = 0; i < array.length - 1; i++) {
        leftSum += array[i];
        let rightSum = totalSum - leftSum;

        if (leftSum % (i + 1) === 0 && rightSum % (array.length - (i + 1)) === 0) {
            count++;
        }
    }

    return count;
}
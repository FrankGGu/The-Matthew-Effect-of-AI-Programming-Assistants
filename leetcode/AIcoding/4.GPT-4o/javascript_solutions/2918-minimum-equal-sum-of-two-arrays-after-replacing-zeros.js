function minimumEqualSum(arr1, arr2) {
    const sum1 = arr1.reduce((a, b) => a + b, 0);
    const sum2 = arr2.reduce((a, b) => a + b, 0);
    const diff = Math.abs(sum1 - sum2);
    const zeros = arr1.filter(x => x === 0).length + arr2.filter(x => x === 0).length;

    if (diff <= zeros) {
        return Math.min(sum1, sum2) + Math.floor((zeros - diff) / 2);
    } else {
        return Math.min(sum1, sum2) + diff;
    }
}
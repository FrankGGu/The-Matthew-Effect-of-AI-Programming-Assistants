function minEqualSumAfterReplaceZeros(arr1, arr2) {
    let sum1 = 0, sum2 = 0;
    let count1 = 0, count2 = 0;

    for (let num of arr1) {
        if (num === 0) count1++;
        else sum1 += num;
    }

    for (let num of arr2) {
        if (num === 0) count2++;
        else sum2 += num;
    }

    if (count1 === 0 && count2 === 0) return Math.max(sum1, sum2);

    let minVal = Math.min(sum1, sum2);
    let maxVal = Math.max(sum1, sum2);

    if (count1 === 0) {
        return maxVal + count2 * (maxVal - minVal);
    } else if (count2 === 0) {
        return maxVal + count1 * (maxVal - minVal);
    } else {
        return maxVal + Math.max(count1, count2) * (maxVal - minVal);
    }
}
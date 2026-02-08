function maxSum(a, b) {
    let i = 0, j = 0;
    let sumA = 0, sumB = 0;
    let result = 0;

    while (i < a.length && j < b.length) {
        if (a[i] < b[j]) {
            sumA += a[i];
            i++;
        } else if (a[i] > b[j]) {
            sumB += b[j];
            j++;
        } else {
            result += Math.max(sumA, sumB) + a[i];
            sumA = 0;
            sumB = 0;
            i++;
            j++;
        }
    }

    while (i < a.length) {
        sumA += a[i];
        i++;
    }

    while (j < b.length) {
        sumB += b[j];
        j++;
    }

    result += Math.max(sumA, sumB);
    return result;
}
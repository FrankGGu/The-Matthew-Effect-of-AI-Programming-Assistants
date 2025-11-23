function kSumSubarray(arr, k, x) {
    let n = arr.length;
    let result = 0;

    for (let i = 0; i <= n - k; i++) {
        let sub = arr.slice(i, i + k);
        sub.sort((a, b) => b - a);
        let sum = 0;
        for (let j = 0; j < x; j++) {
            sum += sub[j];
        }
        result += sum;
    }

    return result;
}
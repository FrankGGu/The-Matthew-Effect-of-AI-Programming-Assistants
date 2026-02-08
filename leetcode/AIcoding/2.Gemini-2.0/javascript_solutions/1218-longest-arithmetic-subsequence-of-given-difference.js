var longestArithSeqLength = function(arr, difference) {
    let n = arr.length;
    let dp = new Map();
    let maxLength = 1;

    for (let i = 0; i < n; i++) {
        for (let j = 0; j < i; j++) {
            if (arr[i] - arr[j] === difference) {
                let key = j + ',' + arr[j];
                let prevLength = dp.has(key) ? dp.get(key) : 1;
                let currKey = i + ',' + arr[i];
                dp.set(currKey, prevLength + 1);
                maxLength = Math.max(maxLength, prevLength + 1);
            }
        }
        let key = i + ',' + arr[i];
        if (!dp.has(key)) {
            dp.set(key, 1);
        }
    }
    return maxLength;
};
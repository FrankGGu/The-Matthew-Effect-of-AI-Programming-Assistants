var containsPattern = function(arr, m, k) {
    for (let i = 0; i <= arr.length - m * k; i++) {
        let pattern = arr.slice(i, i + m);
        let count = 1;
        for (let j = i + m; j <= arr.length - m; j += m) {
            let nextPattern = arr.slice(j, j + m);
            if (JSON.stringify(pattern) === JSON.stringify(nextPattern)) {
                count++;
            } else {
                break;
            }
        }
        if (count >= k) {
            return true;
        }
    }
    return false;
};
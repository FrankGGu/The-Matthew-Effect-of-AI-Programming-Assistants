var optimalHumidity = function(readings, target) {
    let n = readings.length;
    let prefixSum = new Array(n + 1).fill(0);
    for (let i = 1; i <= n; i++) {
        prefixSum[i] = prefixSum[i - 1] + readings[i - 1];
    }

    let minDiff = Infinity;
    let result = [-1, -1];

    for (let i = 1; i <= n; i++) {
        for (let j = i; j <= n; j++) {
            let sum = prefixSum[j] - prefixSum[i - 1];
            let avg = sum / (j - i + 1);
            let diff = Math.abs(avg - target);

            if (diff < minDiff) {
                minDiff = diff;
                result = [i - 1, j - 1];
            } else if (diff === minDiff) {
                if (j - i < result[1] - result[0]) {
                     result = [i - 1, j - 1];
                } else if (j - i === result[1] - result[0] && i - 1 < result[0]) {
                    result = [i - 1, j - 1];
                }
            }
        }
    }

    return result;
};
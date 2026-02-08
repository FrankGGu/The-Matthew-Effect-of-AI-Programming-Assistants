var containsPattern = function(arr, m, k) {
    const n = arr.length;

    if (m * k > n) {
        return false;
    }

    for (let i = 0; i <= n - m * k; i++) {
        let matchCount = 1;

        for (let j = i + m; j <= n - m; j += m) {
            let isCurrentPatternMatch = true;

            for (let p = 0; p < m; p++) {
                if (arr[j + p] !== arr[i + p]) {
                    isCurrentPatternMatch = false;
                    break;
                }
            }

            if (isCurrentPatternMatch) {
                matchCount++;
                if (matchCount === k) {
                    return true;
                }
            } else {
                break;
            }
        }
    }

    return false;
};
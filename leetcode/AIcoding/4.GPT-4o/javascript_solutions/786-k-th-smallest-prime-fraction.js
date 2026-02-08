var kthSmallestPrimeFraction = function(A, K) {
    const n = A.length;
    let left = 0, right = 1;

    while (left < right) {
        const mid = (left + right) / 2;
        let count = 0, maxFraction = 0, numerator = 0, denominator = 1;

        for (let i = 0, j = 1; i < n; i++) {
            while (j < n && A[i] / A[j] > mid) {
                j++;
            }
            count += j;
            if (j > 0) {
                const fraction = A[i] / A[j - 1];
                if (fraction > maxFraction) {
                    maxFraction = fraction;
                    numerator = A[i];
                    denominator = A[j - 1];
                }
            }
        }

        if (count < K) {
            left = mid;
        } else {
            right = mid;
        }
    }

    return [numerator, denominator];
};
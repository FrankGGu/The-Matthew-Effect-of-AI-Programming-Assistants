var kthSmallestPrimeFraction = function(arr, k) {
    const n = arr.length;
    let left = 0, right = 1;
    let p = 0, q = 1;

    while (left < right) {
        const mid = (left + right) / 2;
        let count = 0;
        p = 0;
        for (let i = 0, j = 1; i < n - 1; i++) {
            while (j < n && arr[i] > mid * arr[j]) {
                j++;
            }
            count += n - j;
            if (j < n && p * arr[j] < q * arr[i]) {
                p = arr[i];
                q = arr[j];
            }
        }
        if (count === k) {
            return [p, q];
        } else if (count < k) {
            left = mid;
        } else {
            right = mid;
        }
    }
    return [p, q];
};
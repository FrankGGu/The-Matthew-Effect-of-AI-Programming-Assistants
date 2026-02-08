function maxValue(n, k) {
    let left = 1, right = 1e9;

    while (left < right) {
        let mid = Math.ceil((left + right) / 2);
        let total = 0;

        // Calculate the sum of the first part (from index 0 to k)
        let a = mid - 1;
        let b = a - k;
        if (b > 0) {
            total += (a * (a + 1)) / 2 - (b * (b + 1)) / 2;
        } else {
            total += (a * (a + 1)) / 2;
        }

        // Calculate the sum of the second part (from index k to n-1)
        a = mid - 1;
        b = a - (n - k - 1);
        if (b > 0) {
            total += (a * (a + 1)) / 2 - (b * (b + 1)) / 2;
        } else {
            total += (a * (a + 1)) / 2;
        }

        if (total < n) {
            left = mid;
        } else {
            right = mid - 1;
        }
    }

    return left;
}
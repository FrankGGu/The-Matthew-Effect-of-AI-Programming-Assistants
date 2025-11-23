var hIndex = function(citations) {
    const n = citations.length;
    let low = 0;
    let high = n;
    let ans = 0;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);

        // Check if `mid` can be a valid h-index.
        // This means there are at least `mid` papers with `mid` or more citations.
        // Since the array is sorted, we only need to check the (n - mid)-th paper (0-indexed).
        // If citations[n - mid] >= mid, then all papers from index (n - mid) to (n - 1)
        // (which are `mid` papers) have at least `mid` citations.

        // Edge case: if mid is 0, it's always a valid h-index, and we try for a larger one.
        // If mid is greater than n, it's impossible, so we need a smaller h-index.
        // The binary search range `[0, n]` handles `mid > n` by making `high` eventually `n-1` or less.
        // The condition `n - mid >= 0` ensures we don't access out of bounds for `citations`.

        if (mid === 0) {
            ans = mid;
            low = mid + 1;
        } else if (n - mid >= 0 && citations[n - mid] >= mid) {
            ans = mid;
            low = mid + 1;
        } else {
            high = mid - 1;
        }
    }

    return ans;
};
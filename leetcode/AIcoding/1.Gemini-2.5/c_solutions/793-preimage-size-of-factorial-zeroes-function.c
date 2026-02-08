long long countTrailingZeros(long long n) {
    long long count = 0;
    while (n > 0) {
        n /= 5;
        count += n;
    }
    return count;
}

int preimageSizeFZF(int k) {
    long long low = 0;
    // A safe upper bound for x.
    // The number of trailing zeros in x! is approximately x/4.
    // So, if x/4 = k, then x = 4k. A slightly larger upper bound like 5k+1
    // ensures we cover all possibilities, especially for small k.
    long long high = 5LL * k + 1; 
    long long ans_x = -1; // Stores the smallest x such that countTrailingZeros(x) >= k

    // Binary search to find the smallest x such that countTrailingZeros(x) >= k
    while (low <= high) {
        long long mid = low + (high - low) / 2;
        long long zeros = countTrailingZeros(mid);

        if (zeros >= k) {
            ans_x = mid; // mid is a potential candidate, try to find a smaller one
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    // After binary search, ans_x holds the smallest non-negative integer
    // such that countTrailingZeros(ans_x!) >= k.
    // Since k >= 0 and countTrailingZeros(0!) = 0, ans_x will always be found and not -1.

    // Check if countTrailingZeros(ans_x!) is exactly k.
    if (countTrailingZeros(ans_x) == k) {
        // If it is, then k is a value that countTrailingZeros(x!) can take.
        // Due to the nature of the trailing zeros function (it increments by 1
        // only when x is a multiple of 5, and stays constant for 4 values),
        // if a value k is reachable, there are exactly 5 integers x that map to it.
        // Example: countTrailingZeros(5!) = 1, countTrailingZeros(6!) = 1, ..., countTrailingZeros(9!) = 1.
        return 5;
    } else {
        // If countTrailingZeros(ans_x) > k, it means the value k was skipped.
        // For example, countTrailingZeros(24!) = 4, countTrailingZeros(25!) = 6.
        // The value 5 is skipped. In this case, no x exists such that countTrailingZeros(x!) = k.
        return 0;
    }
}
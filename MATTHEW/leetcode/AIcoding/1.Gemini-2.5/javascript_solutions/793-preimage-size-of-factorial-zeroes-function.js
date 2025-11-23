var preimageSizeFZF = function(k) {
    // Function to calculate the number of trailing zeros in n!
    function countZeros(n) {
        let count = 0;
        while (n >= 5) {
            n = Math.floor(n / 5);
            count += n;
        }
        return count;
    }

    // Binary search to find the smallest x such that countZeros(x) >= k.
    // The number of zeros in x! is approximately x/4. So x is approximately 4k.
    // A safe upper bound for x can be 5 * k + 5.
    // For k = 0, high = 5.
    // For k = 10^9, high = 5 * 10^9 + 5.
    let low = 0;
    let high = 5 * k + 5; 
    let lowerBoundX = high; // Stores the smallest x found so far that satisfies countZeros(x) >= k

    while (low <= high) {
        let mid = low + Math.floor((high - low) / 2);
        if (countZeros(mid) >= k) {
            lowerBoundX = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    // After the binary search, lowerBoundX is the smallest non-negative integer x
    // such that countZeros(x) >= k.
    // If countZeros(lowerBoundX) === k, it means k is an achievable number of zeros.
    // Due to the nature of the countZeros function (it increases by 1 for every 5 numbers,
    // except when crossing a multiple of 25, 125, etc., where it jumps by more than 1),
    // if k is achievable, there will always be exactly 5 consecutive integers x
    // for which countZeros(x) = k.
    // For example, if countZeros(x) = 1, then x can be 5, 6, 7, 8, or 9.
    // If countZeros(lowerBoundX) > k, it means k was "skipped" by the countZeros function.
    // For example, countZeros(24) = 4, countZeros(25) = 6. The value 5 is skipped.
    // In this case, no x exists such that countZeros(x) = k.
    if (countZeros(lowerBoundX) === k) {
        return 5;
    } else {
        return 0;
    }
};
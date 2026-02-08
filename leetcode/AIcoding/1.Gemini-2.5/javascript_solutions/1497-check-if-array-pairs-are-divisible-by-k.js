var canArrange = function(arr, k) {
    const freq = new Array(k).fill(0);

    for (const num of arr) {
        // Calculate the remainder ensuring it's non-negative
        // JavaScript's % operator can return negative results for negative dividends
        freq[(num % k + k) % k]++;
    }

    // Check if numbers with remainder 0 can be paired
    // They must pair with other numbers with remainder 0
    if (freq[0] % 2 !== 0) {
        return false;
    }

    // Check remainders for i from 1 up to k/2
    // If k is odd, i goes up to (k-1)/2.
    // If k is even, i goes up to k/2.
    // The k/2 case (if k is even) is handled separately in the loop.
    for (let i = 1; i <= k / 2; i++) {
        if (i === k - i) { // This condition is true only if k is even and i is k/2
            // Numbers with remainder k/2 must pair with other numbers with remainder k/2
            if (freq[i] % 2 !== 0) {
                return false;
            }
        } else {
            // Numbers with remainder i must pair with numbers with remainder k-i
            if (freq[i] !== freq[k - i]) {
                return false;
            }
        }
    }

    return true;
};
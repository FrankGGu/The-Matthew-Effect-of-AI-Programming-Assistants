function longestDuplicateSubstring(s) {
    const n = s.length;
    if (n <= 1) return "";

    // Helper for modular exponentiation (base^exp % mod)
    function power(base, exp, mod) {
        let res = 1;
        base %= mod;
        while (exp > 0) {
            if (exp % 2 === 1) res = (res * base) % mod;
            base = (base * base) % mod;
            exp = Math.floor(exp / 2);
        }
        return res;
    }

    // Convert string characters to 1-indexed numbers (a=1, b=2, ...)
    // This assumes lowercase English letters as per problem constraints.
    const nums = new Array(n);
    for (let i = 0; i < n; i++) {
        nums[i] = s.charCodeAt(i) - 'a'.charCodeAt(0) + 1;
    }

    const base = 29; // A prime number greater than 26 (alphabet size)
    const mod = 1_000_000_007; // A large prime modulus

    let longestDupStart = 0;
    let longestDupLength = 0;

    // Binary search for the length of the longest duplicate substring
    // The length can range from 1 to n-1.
    let low = 1;
    let high = n - 1;

    while (low <= high) {
        let mid = Math.floor(low + (high - low) / 2);
        let foundIndex = findDuplicate(mid);

        if (foundIndex !== -1) {
            // A duplicate substring of length 'mid' was found.
            // Store this length and its starting index, then try for a longer one.
            longestDupLength = mid;
            longestDupStart = foundIndex;
            low = mid + 1;
        } else {
            // No duplicate substring of length 'mid' was found.
            // Try for a shorter one.
            high = mid - 1;
        }
    }

    // Helper function to find a duplicate substring of a given length 'len'.
    // Returns the starting index of one such duplicate, or -1 if none exists.
    function findDuplicate(len) {
        if (len === 0) return 0; // A 0-length string is always duplicated, but we search for len >= 1.
        if (len > n) return -1;

        // Calculate (base^(len-1)) % mod for rolling hash
        const p_pow = power(base, len - 1, mod);

        let currentHash = 0;
        // Calculate hash for the first substring of length 'len' (s[0...len-1])
        for (let i = 0; i < len; i++) {
            currentHash = (currentHash * base + nums[i]) % mod;
        }

        // Store hashes and their starting indices to detect duplicates.
        // Map: hash_value -> starting_index
        const seenHashes = new Map();
        seenHashes.set(currentHash, 0);

        // Iterate through the rest of the substrings using rolling hash
        for (let i = 1; i <= n - len; i++) {
            // Remove the contribution of the character leaving the window (nums[i-1])
            currentHash = (currentHash - (nums[i - 1] * p_pow) % mod + mod) % mod;
            // Add the contribution of the new character entering the window (nums[i + len - 1])
            currentHash = (currentHash * base + nums[i + len - 1]) % mod;

            if (seenHashes.has(currentHash)) {
                // A duplicate hash was found. Return the current starting index.
                // In competitive programming, for Rabin-Karp, explicit string comparison
                // to handle hash collisions is often skipped for performance,
                // relying on a low probability of collision with good base/modulus choices.
                return i;
            }
            seenHashes.set(currentHash, i);
        }
        return -1; // No duplicate of this length found
    }

    // Return the substring based on the longest duplicate found
    return s.substring(longestDupStart, longestDupStart + longestDupLength);
}
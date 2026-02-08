var subStrHash = function(s, power, modulo, k, hashValue) {
    const n = s.length;

    // Helper function to get character value (a=1, b=2, ..., z=26)
    const charVal = (char) => char.charCodeAt(0) - 'a'.charCodeAt(0) + 1;

    // Calculate power^(k-1) % modulo. This is used to remove the contribution
    // of the leftmost character when rolling the hash.
    let powerKMinus1 = 1;
    for (let i = 0; i < k - 1; i++) {
        powerKMinus1 = (powerKMinus1 * power) % modulo;
    }

    // Calculate the hash for the rightmost substring of length k: s[n-k ... n-1].
    // The hash function is defined as:
    // hash(s[0...k-1]) = (s[0] * power^(k-1) + s[1] * power^(k-2) + ... + s[k-1] * power^0) % modulo
    // To calculate this efficiently from right to left, we can use a reverse perspective.
    // The hash value for s[i...i+k-1] is effectively
    // (s[i+k-1]*power^0 + s[i+k-2]*power^1 + ... + s[i]*power^(k-1)) % modulo
    // if we compute it by processing characters from right to left (s[i+k-1] first, then s[i+k-2], etc.).
    // This allows for O(1) rolling from right to left without modular inverse.

    let currentHash = 0;
    let currentPower = 1; // Represents power^0, power^1, power^2, ...
    let resultIndex = -1;

    // Iterate from the rightmost character of the string s (index n-1)
    // to the leftmost character (index 0).
    for (let i = n - 1; i >= 0; i--) {
        // Add the current character's contribution to the hash.
        // The character s[i] corresponds to power^(n-1-i) if we were building the hash from left to right.
        // But we are building it from right to left for a window of size k.
        // This means s[i] is the newest character to be included in the window.
        // Its position in the window is (k-1) - (current window length - 1), effectively power^0.
        // No, this is incorrect. The problem's hash definition is fixed.

        // To find the RIGHTMOST substring, we iterate from right to left.
        // Let's calculate the hash for the substring s[i...i+k-1].
        // We can maintain the current hash for the window s[i+1...i+k]
        // and update it to get the hash for s[i...i+k-1].

        // Let's use the definition: H(sub) = (sub[0]*P^(k-1) + ... + sub[k-1]*P^0) % M
        // We want to find the rightmost such substring.
        // Iterate `i` from `n-1` down to `0`.
        // `currentHash` will represent the hash of `s[i...i+k-1]`.

        // Build the hash for the window ending at `s[i]`.
        // If `i + k - 1 >= n`, the window is not fully formed yet.
        // `currentHash` will store the hash of `s[i...i+k-1]`.
        // We want to compute this for `i = n-k` down to `0`.

        // Let's use the O(N) space solution to avoid confusion and ensure correctness for rightmost.
        // The initial analysis of the rolling hash formula:
        // H_new = ((H_old - charVal(s[old_first]) * P^(k-1)) * P + charVal(s[new_last])) % M
        // This formula is for moving the window from left to right.
        // And it correctly implements the problem's stated hash function:
        // hash(s[0...k-1]) = (s[0] * power^(k-1) + s[1] * power^(k-2) + ... + s[k-1] * power^0) % modulo

        const hashes = new Array(n - k + 1);

        // Calculate initial hash for s[0...k-1]
        let currentWindowHash = 0;
        for (let i = 0; i < k; i++) {
            currentWindowHash = (currentWindowHash * power + charVal(s[i])) % modulo;
        }
        hashes[0] = currentWindowHash;

        // Roll the hash for subsequent windows (from left to right)
        for (let i = 1; i <= n - k; i++) {
            // Remove the contribution of the character leaving the window (s[i-1])
            // Its contribution was charVal(s[i-1]) * power^(k-1)
            let termToRemove = (charVal(s[i-1]) * powerKMinus1) % modulo;
            currentWindowHash = (currentWindowHash - termToRemove + modulo) % modulo; // Ensure positive result

            // Shift the remaining hash to the left (multiply by power)
            currentWindowHash = (currentWindowHash * power) % modulo;

            // Add the contribution of the new character entering the window (s[i+k-1])
            // Its contribution is charVal(s[i+k-1]) * power^0
            currentWindowHash = (currentWindowHash + charVal(s[i+k-1])) % modulo;
            hashes[i] = currentWindowHash;
        }

        // Find the rightmost substring that matches hashValue
        for (let i = n - k; i >= 0; i--) {
            if (hashes[i] === hashValue) {
                return i;
            }
        }

        return -1; // No such substring found
};
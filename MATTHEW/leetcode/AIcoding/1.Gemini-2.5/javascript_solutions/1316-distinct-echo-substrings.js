var distinctEchoSubstrings = function(s) {
    const n = s.length;
    const distinctEchoes = new Set();

    // Rolling hash parameters
    // Using two hash functions to minimize collision probability
    const P1 = 31; // A prime base for hash 1
    const M1 = 1_000_000_007; // A large prime modulus for hash 1
    const P2 = 37; // A prime base for hash 2
    const M2 = 1_000_000_009; // A large prime modulus for hash 2

    // Precompute powers of P1 and P2
    // powers[k] stores P^k % M
    const powers1 = new Array(n + 1);
    const powers2 = new Array(n + 1);
    powers1[0] = 1;
    powers2[0] = 1;
    for (let k = 1; k <= n; k++) {
        powers1[k] = (powers1[k - 1] * P1) % M1;
        powers2[k] = (powers2[k - 1] * P2) % M2;
    }

    // Precompute prefix hashes
    // hashes[k] stores hash of s[0...k-1]
    // hash(s[0...k-1]) = (s[0]*P^(k-1) + s[1]*P^(k-2) + ... + s[k-1]*P^0) % M
    // Or, using the common form: hash(s[0...k-1]) = (s[0]*P^0 + s[1]*P^1 + ... + s[k-1]*P^(k-1)) % M
    // The implementation below uses the form: hash(s[0...k-1]) = (s[0]*P^(k-1) + s[1]*P^(k-2) + ... + s[k-1]*P^0) % M
    // For this form, `hashes[k] = (hashes[k-1] * P + charCode) % M`
    const hashes1 = new Array(n + 1);
    const hashes2 = new Array(n + 1);
    hashes1[0] = 0;
    hashes2[0] = 0;
    for (let k = 1; k <= n; k++) {
        // Map 'a' to 1, 'b' to 2, etc., to avoid zero hash for 'a' and ensure non-zero char values.
        const charCode = s.charCodeAt(k - 1) - 'a'.charCodeAt(0) + 1;
        hashes1[k] = (hashes1[k - 1] * P1 + charCode) % M1;
        hashes2[k] = (hashes2[k - 1] * P2 + charCode) % M2;
    }

    // Function to get hash of substring s[start...end] (inclusive)
    // `hashes[idx]` stores hash of `s[0...idx-1]`
    // `hash(s[start...end]) = (hashes[end+1] - hashes[start] * P^len) % M`
    // We add M and take modulo again to handle potential negative results from subtraction.
    const getHash = (start, end, hashes, powers, M) => {
        const len = end - start + 1;
        let val = (hashes[end + 1] - (hashes[start] * powers[len]) % M + M) % M;
        return val;
    };

    // Iterate through all possible lengths of the echo substring
    // Length must be even, minimum length is 2
    for (let len = 2; len <= n; len += 2) {
        const halfLen = len / 2;
        // Iterate through all possible starting positions for a substring of current `len`
        for (let i = 0; i <= n - len; i++) {
            const j = i + len - 1; // Ending position of the full substring

            // Define the two halves of the substring
            // First half: s[i ... i + halfLen - 1]
            const firstHalfStart = i;
            const firstHalfEnd = i + halfLen - 1;

            // Second half: s[i + halfLen ... j]
            const secondHalfStart = i + halfLen;
            const secondHalfEnd = j;

            // Calculate hash pairs for both halves
            const hash1_first = getHash(firstHalfStart, firstHalfEnd, hashes1, powers1, M1);
            const hash2_first = getHash(firstHalfStart, firstHalfEnd, hashes2, powers2, M2);

            const hash1_second = getHash(secondHalfStart, secondHalfEnd, hashes1, powers1, M1);
            const hash2_second = getHash(secondHalfStart, secondHalfEnd, hashes2, powers2, M2);

            // If both hash pairs match, it's considered an echo substring
            // We store a string representation of the hash pair to count distinct echo substrings
            // This relies on the very low probability of hash collisions for distinct strings.
            if (hash1_first === hash1_second && hash2_first === hash2_second) {
                distinctEchoes.add(`${hash1_first},${hash2_first}`);
            }
        }
    }

    return distinctEchoes.size;
};
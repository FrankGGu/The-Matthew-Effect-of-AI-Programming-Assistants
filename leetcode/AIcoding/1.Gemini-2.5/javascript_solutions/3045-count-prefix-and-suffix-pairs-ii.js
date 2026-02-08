const P1 = 31;
const M1 = 1e9 + 7;
const P2 = 37;
const M2 = 1e9 + 9;
const MAX_TOTAL_LEN = 100000; // Sum of words[k].length is at most 10^5

const powers1 = new Array(MAX_TOTAL_LEN + 1);
const powers2 = new Array(MAX_TOTAL_LEN + 1);

powers1[0] = 1;
powers2[0] = 1;
for (let i = 1; i <= MAX_TOTAL_LEN; i++) {
    powers1[i] = (powers1[i - 1] * P1) % M1;
    powers2[i] = (powers2[i - 1] * P2) % M2;
}

var countPrefixSuffixPairs = function(words) {
    let ans = 0;

    // Map to store frequencies of (hash1, hash2) pairs for words encountered so far
    // Key: "hash1,hash2" string, Value: count
    const freqMap = new Map();

    for (const word of words) {
        const L = word.length;

        // Arrays to store hashes for prefixes/suffixes of length 1, 2, ..., L
        // prefixHashes[k] will store hash of word[0...k] (length k+1)
        // suffixHashes[k] will store hash of word[L-(k+1)...L-1] (length k+1)
        const prefixHashes1 = new Array(L);
        const suffixHashes1 = new Array(L);
        const prefixHashes2 = new Array(L);
        const suffixHashes2 = new Array(L);

        // --- Calculate prefix hashes ---
        let currentPrefixHash1 = 0;
        let currentPrefixHash2 = 0;

        for (let k = 0; k < L; k++) {
            const charCode = word.charCodeAt(k) - 96; // 'a' is 1, 'b' is 2, etc.
            currentPrefixHash1 = (currentPrefixHash1 * P1 + charCode) % M1;
            currentPrefixHash2 = (currentPrefixHash2 * P2 + charCode) % M2;
            prefixHashes1[k] = currentPrefixHash1;
            prefixHashes2[k] = currentPrefixHash2;
        }

        // --- Calculate suffix hashes ---
        let currentSuffixHash1 = 0;
        let currentSuffixHash2 = 0;

        // Iterating from the end of the string to build suffix hashes
        // For a suffix of length `k+1`, it's `word[L-(k+1)...L-1]`
        // `currentSuffixHash` will store the hash of this substring.
        // We use `powers1[k]` and `powers2[k]` to multiply characters by `P^0, P^1, ...`
        for (let k = 0; k < L; k++) {
            const charCode = word.charCodeAt(L - 1 - k) - 96; // Character from right to left

            // Hash of word[L-1-k ... L-1]
            // This is equivalent to hash(word[L-1-k] + ... + word[L-1])
            currentSuffixHash1 = (currentSuffixHash1 + charCode * powers1[k]) % M1;
            currentSuffixHash2 = (currentSuffixHash2 + charCode * powers2[k]) % M2;

            // Store it at index `k` for length `k+1`
            suffixHashes1[k] = currentSuffixHash1;
            suffixHashes2[k] = currentSuffixHash2;
        }

        // --- Compare prefix and suffix hashes ---
        // For each possible length `len` (from 1 to L), check if prefix of `len` == suffix of `len`
        for (let len = 1; len <= L; len++) {
            // `len` corresponds to index `len-1` in hash arrays
            // prefixHashes[len-1] is hash of word[0...len-1]
            // suffixHashes[len-1] is hash of word[L-len...L-1]
            if (prefixHashes1[len - 1] === suffixHashes1[len - 1] &&
                prefixHashes2[len - 1] === suffixHashes2[len - 1]) {

                const key = `${prefixHashes1[len - 1]},${prefixHashes2[len - 1]}`;
                ans += freqMap.get(key) || 0;
            }
        }

        // --- Add the current word's full hash to the frequency map ---
        const fullWordHash1 = prefixHashes1[L - 1]; // Hash of the entire word
        const fullWordHash2 = prefixHashes2[L - 1];
        const key = `${fullWordHash1},${fullWordHash2}`;
        freqMap.set(key, (freqMap.get(key) || 0) + 1);
    }

    return ans;
};
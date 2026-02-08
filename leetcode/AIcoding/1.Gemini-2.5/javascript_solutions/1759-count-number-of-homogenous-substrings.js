var countHomogenous = function(s) {
    let totalCount = 0;
    const MOD = 10 ** 9 + 7;
    let i = 0;
    const n = s.length;

    while (i < n) {
        let j = i;
        while (j < n && s[j] === s[i]) {
            j++;
        }

        // s[i...j-1] is a homogenous block of characters
        const length = j - i;

        // Number of homogenous substrings in a block of length 'L' is L * (L + 1) / 2
        // Example: "aaa" (L=3) -> "a", "a", "a", "aa", "aa", "aaa" = 6 substrings.
        // 3 * (3 + 1) / 2 = 6
        const substringsInBlock = (length * (length + 1)) / 2;

        totalCount = (totalCount + substringsInBlock) % MOD;

        i = j; // Move to the next distinct character block
    }

    return totalCount;
};
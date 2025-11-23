function calculateZArray(s) {
    const n = s.length;
    const Z = new Array(n).fill(0);
    let L = 0, R = 0;
    for (let i = 1; i < n; i++) {
        if (i <= R) {
            Z[i] = Math.min(R - i + 1, Z[i - L]);
        }
        while (i + Z[i] < n && s[Z[i]] === s[i + Z[i]]) {
            Z[i]++;
        }
        if (i + Z[i] - 1 > R) {
            L = i;
            R = i + Z[i] - 1;
        }
    }
    return Z;
}

var minimumTimeToRevert = function(word, k) {
    const n = word.length;

    // We are looking for the smallest t >= 1 such that `word` rotated left by `t*k` positions
    // is equal to the original `word`.
    // A string `S` rotated left by `X` positions is equivalent to `(S+S).substring(X, X+S.length)`.
    // We need to find the smallest `t` such that `(word+word).substring(t*k, t*k + n)` is equal to `word`.
    // This is a string matching problem. We can use the Z-algorithm.

    // Construct the string for Z-algorithm: `P + '$' + T`
    // where `P = word` (the pattern to find) and `T = word + word` (the text to search in).
    const textForZ = word + '$' + word + word;
    const Z = calculateZArray(textForZ);

    // The length of the pattern `P` is `n`. The separator `$` is at index `n`.
    // The text `T` (`word+word`) starts at index `n + 1` in `textForZ`.
    // An occurrence of `word` starting at index `j` in `word+word` corresponds to
    // `Z[n + 1 + j]` being equal to `n`.

    for (let t = 1; t <= n; t++) {
        // Calculate the total shift amount after `t` operations.
        // The effective shift is `(t * k) % n`.
        // This `effectiveShift` is the starting index in `word+word` for the current state of the word.
        const effectiveShift = (t * k) % n;

        // Check the Z-value for the corresponding index in `textForZ`.
        // `Z[n + 1 + effectiveShift]` gives the length of the longest common prefix
        // between `word` (the pattern) and the substring of `word+word` starting at `effectiveShift`.
        // If this length is `n`, it means `word` itself is found.
        if (Z[n + 1 + effectiveShift] === n) {
            return t;
        }
    }

    // According to the problem constraints and properties of string rotations,
    // a solution will always be found within `t <= n`.
    // Specifically, when `t = n`, the total shift is `n*k`.
    // The effective shift `(n*k) % n` will be `0`.
    // `Z[n + 1 + 0]` (which is `Z[n+1]`) will be `n` because `word+word` starts with `word`.
    // So, `t=n` is always a valid answer if no smaller `t` is found.
    return n; 
};
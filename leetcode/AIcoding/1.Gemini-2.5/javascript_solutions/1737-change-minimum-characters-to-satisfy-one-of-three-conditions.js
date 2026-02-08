var minCharacters = function(a, b) {
    const freqA = new Array(26).fill(0);
    const freqB = new Array(26).fill(0);

    for (let i = 0; i < a.length; i++) {
        freqA[a.charCodeAt(i) - 97]++;
    }
    for (let i = 0; i < b.length; i++) {
        freqB[b.charCodeAt(i) - 97]++;
    }

    const prefixSumA = new Array(26).fill(0);
    const prefixSumB = new Array(26).fill(0);

    prefixSumA[0] = freqA[0];
    prefixSumB[0] = freqB[0];
    for (let i = 1; i < 26; i++) {
        prefixSumA[i] = prefixSumA[i - 1] + freqA[i];
        prefixSumB[i] = prefixSumB[i - 1] + freqB[i];
    }

    let minChanges = Infinity;

    // Condition 1: Every character in a is strictly less than every character in b.
    // This means there exists a character `k` (from 'a' to 'y') such that
    // all characters in `a` are <= `k` and all characters in `b` are > `k`.
    // We iterate `i` from 0 to 24, representing `k` from 'a' to 'y'.
    for (let i = 0; i < 25; i++) {
        // Cost for 'a': characters in 'a' that are > i must be changed.
        // These are `a.length - prefixSumA[i]`.
        const costA = a.length - prefixSumA[i];
        // Cost for 'b': characters in 'b' that are <= i must be changed.
        // These are `prefixSumB[i]`.
        const costB = prefixSumB[i];
        minChanges = Math.min(minChanges, costA + costB);
    }

    // Condition 2: Every character in b is strictly less than every character in a.
    // This is symmetric to Condition 1.
    // There exists a character `k` (from 'a' to 'y') such that
    // all characters in `b` are <= `k` and all characters in `a` are > `k`.
    // We iterate `i` from 0 to 24, representing `k` from 'a' to 'y'.
    for (let i = 0; i < 25; i++) {
        // Cost for 'b': characters in 'b' that are > i must be changed.
        // These are `b.length - prefixSumB[i]`.
        const costB = b.length - prefixSumB[i];
        // Cost for 'a': characters in 'a' that are <= i must be changed.
        // These are `prefixSumA[i]`.
        const costA = prefixSumA[i];
        minChanges = Math.min(minChanges, costA + costB);
    }

    // Condition 3: Every character in a and every character in b are the same character.
    // We iterate through all possible target characters 'a' through 'z' (index 0 to 25).
    for (let i = 0; i < 26; i++) {
        // Cost for 'a': characters in 'a' that are not 'i' must be changed.
        // These are `a.length - freqA[i]`.
        const costA = a.length - freqA[i];
        // Cost for 'b': characters in 'b' that are not 'i' must be changed.
        // These are `b.length - freqB[i]`.
        const costB = b.length - freqB[i];
        minChanges = Math.min(minChanges, costA + costB);
    }

    return minChanges;
};
function maximumPalindromesAfterOperations(s) {
    const freq = new Array(26).fill(0);
    for (const c of s) {
        freq[c.charCodeAt(0) - 'a'.charCodeAt(0)]++;
    }

    let evenCount = 0;
    let oddCount = 0;

    for (let i = 0; i < 26; i++) {
        if (freq[i] % 2 === 0) {
            evenCount += freq[i] / 2;
        } else {
            evenCount += Math.floor(freq[i] / 2);
            oddCount++;
        }
    }

    let maxPalindromes = 0;
    let hasMiddle = false;

    for (let i = 0; i < 26; i++) {
        if (freq[i] >= 2) {
            maxPalindromes += Math.floor(freq[i] / 2);
        }
    }

    if (oddCount > 0) {
        hasMiddle = true;
    }

    return hasMiddle ? maxPalindromes + 1 : maxPalindromes;
}
var maxPalindromesAfterOperations = function(words, k) {
    const freq = new Array(26).fill(0);

    for (const word of words) {
        for (const char of word) {
            freq[char.charCodeAt(0) - 'a'.charCodeAt(0)]++;
        }
    }

    let totalPairs = 0;
    let totalOddChars = 0;

    for (let i = 0; i < 26; i++) {
        totalPairs += Math.floor(freq[i] / 2);
        totalOddChars += freq[i] % 2;
    }

    if (k === 1) {
        return totalPairs * 2 + totalOddChars;
    }

    let ans = 0;
    const pairsNeeded = Math.floor(k / 2);
    const singleNeeded = k % 2; // 0 if k is even, 1 if k is odd

    while (totalPairs >= pairsNeeded) {
        if (singleNeeded === 0) { // k is even, no single character needed
            totalPairs -= pairsNeeded;
            ans++;
        } else { // k is odd, one single character needed
            if (totalOddChars > 0) {
                totalPairs -= pairsNeeded;
                totalOddChars--;
                ans++;
            } else if (totalPairs >= pairsNeeded + 1) { // Can break one pair to get a center character
                totalPairs -= (pairsNeeded + 1);
                ans++;
            } else { // Not enough pairs or odd characters to form an odd-length palindrome
                break;
            }
        }
    }

    return ans;
};
var nearestPalindromic = function(n) {
    const num_n = BigInt(n);
    const L = n.length;

    // Helper function to build a palindrome from its first half string
    function buildPalindrome(halfStr, isEvenLength) {
        const reversedHalf = halfStr.split('').reverse().join('');
        if (isEvenLength) {
            return halfStr + reversedHalf;
        } else {
            return halfStr + reversedHalf.substring(1);
        }
    }

    const candidates = new Set();

    // Candidate 1: Palindrome with length L-1 (e.g., 9, 99, 999)
    // This is 10^(L-1) - 1
    if (L > 1) {
        candidates.add(BigInt(10 ** (L - 1)) - 1n);
    }

    // Candidate 2: Palindrome with length L+1 (e.g., 11, 101, 1001)
    // This is 10^L + 1
    candidates.add(BigInt(10 ** L) + 1n);

    // Candidates based on the first half of n
    const halfLen = Math.ceil(L / 2);
    const prefixStr = n.substring(0, halfLen);
    const prefixNum = BigInt(prefixStr);

    // Generate palindromes from prefixNum - 1, prefixNum, prefixNum + 1
    for (let i = -1; i <= 1; i++) {
        const currentHalfNum = prefixNum + BigInt(i);

        // Handle cases where prefixNum-1 results in 0 or negative (e.g., n="1", prefixNum=1, currentHalfNum=0)
        if (currentHalfNum <= 0n) {
            // For n="1", prefixNum-1=0, which should generate "0"
            if (currentHalfNum === 0n && L === 1) {
                 candidates.add(0n);
            }
            continue; 
        }

        const palindromeStr = buildPalindrome(currentHalfNum.toString(), L % 2 === 0);
        candidates.add(BigInt(palindromeStr));
    }

    let minDiff = -1n; // Using -1n to indicate it's not yet set
    let result = "";

    for (const cand of candidates) {
        if (cand === num_n) {
            continue; // Skip n itself if it's a palindrome
        }

        const diff = (cand > num_n) ? cand - num_n : num_n - cand; // abs(cand - num_n)

        if (minDiff === -1n || diff < minDiff) {
            minDiff = diff;
            result = cand.toString();
        } else if (diff === minDiff) {
            // If differences are equal, choose the smaller palindrome
            if (BigInt(cand) < BigInt(result)) {
                result = cand.toString();
            }
        }
    }

    return result;
};
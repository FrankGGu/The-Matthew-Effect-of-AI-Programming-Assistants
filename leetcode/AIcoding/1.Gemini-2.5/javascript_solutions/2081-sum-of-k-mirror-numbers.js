var sumBaseK = function(n, k) {
    let foundCount = 0;
    let currentSum = 0n; // Use BigInt for sum as numbers can exceed Number.MAX_SAFE_INTEGER

    // Helper function to check if a string is a palindrome
    const isPalindrome = (s) => {
        let left = 0;
        let right = s.length - 1;
        while (left < right) {
            if (s[left] !== s[right]) {
                return false;
            }
            left++;
            right--;
        }
        return true;
    };

    // Helper function to convert a BigInt number to its base k string representation
    const toBaseK = (val, base) => {
        if (val === 0n) return "0"; // Should not be reached for positive k-mirror numbers
        let res = "";
        let tempVal = val;
        let b = BigInt(base);
        while (tempVal > 0n) {
            res = (tempVal % b) + res;
            tempVal = tempVal / b;
        }
        return res;
    };

    // Initialize the smallest odd-length and even-length base-10 palindromes
    // and their respective prefixes.
    // The generation strategy ensures palindromes are considered in increasing order.
    let nextOddPalindrome = 1n; // Smallest odd-length palindrome (1, 2, ..., 9)
    let nextEvenPalindrome = 11n; // Smallest even-length palindrome (11, 22, ..., 99)

    let currentOddPrefix = 1n; // Prefix used to generate nextOddPalindrome
    let currentEvenPrefix = 1n; // Prefix used to generate nextEvenPalindrome

    while (foundCount < n) {
        let candidate;

        // Choose the smaller of the next available odd-length or even-length palindrome
        if (nextOddPalindrome < nextEvenPalindrome) {
            candidate = nextOddPalindrome;

            // Generate the next odd-length palindrome
            currentOddPrefix++;
            let s = currentOddPrefix.toString();
            // For odd length, the middle digit is not reversed, so we reverse prefix excluding last digit
            let reversedPrefixWithoutLast = s.substring(0, s.length - 1).split('').reverse().join('');
            nextOddPalindrome = BigInt(s + reversedPrefixWithoutLast);
        } else {
            candidate = nextEvenPalindrome;

            // Generate the next even-length palindrome
            currentEvenPrefix++;
            let s = currentEvenPrefix.toString();
            // For even length, the entire prefix is reversed and appended
            let reversedPrefix = s.split('').reverse().join('');
            nextEvenPalindrome = BigInt(s + reversedPrefix);
        }

        // The candidate is a base 10 palindrome by construction.
        // Now, check if its base k representation is also a palindrome.
        if (isPalindrome(toBaseK(candidate, k))) {
            currentSum += candidate;
            foundCount++;
        }
    }

    // Return the sum as a string, as BigInt results are often expected this way in LeetCode JS.
    return currentSum.toString();
};
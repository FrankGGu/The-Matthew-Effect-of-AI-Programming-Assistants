var kthPalindrome = function(queries, intLength) {
    const results = [];

    const halfLength = Math.ceil(intLength / 2);

    const startNum = Math.pow(10, halfLength - 1);
    const endNum = Math.pow(10, halfLength) - 1;

    for (const q of queries) {
        const currentHalfNum = startNum + q - 1;

        if (currentHalfNum > endNum) {
            results.push(-1);
            continue;
        }

        const firstHalfStr = String(currentHalfNum);

        const secondHalfStrReversed = firstHalfStr.split('').reverse().join('');

        // If intLength is odd, the middle digit is the last digit of firstHalfStr.
        // This digit is the first character of secondHalfStrReversed.
        // We need to skip it to avoid duplicating the middle digit.
        // intLength % 2 will be 1 for odd, 0 for even.
        const palindromeStr = firstHalfStr + secondHalfStrReversed.substring(intLength % 2);

        results.push(Number(palindromeStr));
    }

    return results;
};
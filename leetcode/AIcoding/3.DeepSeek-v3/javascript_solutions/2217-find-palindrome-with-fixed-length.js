var kthPalindrome = function(queries, intLength) {
    const result = [];
    const halfLength = Math.ceil(intLength / 2);
    const start = Math.pow(10, halfLength - 1);
    const end = Math.pow(10, halfLength) - 1;

    for (const q of queries) {
        const half = start + q - 1;
        if (half > end) {
            result.push(-1);
            continue;
        }
        const halfStr = half.toString();
        let palindromeStr = halfStr;
        if (intLength % 2 === 1) {
            palindromeStr += halfStr.slice(0, -1).split('').reverse().join('');
        } else {
            palindromeStr += halfStr.split('').reverse().join('');
        }
        result.push(parseInt(palindromeStr, 10));
    }

    return result;
};
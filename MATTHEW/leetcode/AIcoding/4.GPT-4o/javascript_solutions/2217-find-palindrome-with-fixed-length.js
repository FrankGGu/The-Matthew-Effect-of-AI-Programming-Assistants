function kthPalindrome(queries, intLength) {
    const result = [];
    const halfLength = Math.ceil(intLength / 2);
    const start = Math.pow(10, halfLength - 1);

    for (const k of queries) {
        const num = start + k - 1;
        let str = num.toString();
        let palindrome = str;

        if (intLength % 2 === 0) {
            palindrome += str.split('').reverse().join('');
        } else {
            palindrome += str.slice(0, -1).split('').reverse().join('');
        }

        result.push(palindrome.length === intLength ? palindrome : -1);
    }

    return result;
}
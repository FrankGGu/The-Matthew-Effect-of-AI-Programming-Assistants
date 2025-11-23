var largestPalindrome = function(n) {
    if (n === 1) return 9;
    const upper = Math.pow(10, n) - 1;
    const lower = Math.pow(10, n - 1);
    const maxNum = upper * upper;
    const firstHalf = Math.floor(maxNum / Math.pow(10, n));

    for (let left = firstHalf; left >= lower; left--) {
        const palindrome = createPalindrome(left);
        for (let divisor = upper; divisor >= lower; divisor--) {
            if (palindrome / divisor > upper) break;
            if (palindrome % divisor === 0) {
                return palindrome % 1337;
            }
        }
    }
    return -1;
};

function createPalindrome(left) {
    const str = left.toString();
    const reversed = str.split('').reverse().join('');
    return parseInt(str + reversed, 10);
}
var largestPalindrome = function(n) {
    if (n === 1) return 9;
    const max = Math.pow(10, n) - 1;
    const min = Math.pow(10, n - 1);
    for (let i = max; i >= min; i--) {
        let palindrome = String(i);
        palindrome += String(i).split('').reverse().join('');
        palindrome = parseInt(palindrome);
        for (let j = max; j * j >= palindrome; j--) {
            if (palindrome % j === 0 && palindrome / j <= max) {
                return palindrome % 1337;
            }
        }
    }
};
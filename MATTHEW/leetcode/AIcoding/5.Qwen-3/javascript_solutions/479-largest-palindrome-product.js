function largestPalindrome(n) {
    if (n === 1) return 9;
    const max = Math.pow(10, n) - 1;
    const min = Math.pow(10, n - 1);
    for (let i = max; i >= min; i--) {
        let num = i;
        let reverse = i;
        while (reverse > 0) {
            num = num * 10 + (reverse % 10);
            reverse = Math.floor(reverse / 10);
        }
        for (let j = max; j >= min; j--) {
            if (num / j > max) break;
            if (num % j === 0) return num % 1000000007;
        }
    }
    return -1;
}
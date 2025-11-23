function isStrictlyPalindromic(n) {
    for (let i = 2; i <= n - 1; i++) {
        let s = '';
        let num = n;
        while (num > 0) {
            s = (num % i) + s;
            num = Math.floor(num / i);
        }
        if (s !== s.split('').reverse().join('')) {
            return false;
        }
    }
    return true;
}
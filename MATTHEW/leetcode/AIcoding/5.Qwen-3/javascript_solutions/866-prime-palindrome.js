function primePalindrome(n) {
    function isPrime(x) {
        if (x < 2) return false;
        for (let i = 2; i * i <= x; i++) {
            if (x % i === 0) return false;
        }
        return true;
    }

    for (let i = n; ; i++) {
        if (isPrime(i) && String(i) === String(i).split('').reverse().join('')) {
            return i;
        }
    }
}
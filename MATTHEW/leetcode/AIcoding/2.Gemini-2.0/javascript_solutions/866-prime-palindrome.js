var primePalindrome = function(n) {
    if (n >= 8 && n <= 11) return 11;
    for (let i = 1; i <= 100000; i++) {
        let s = i.toString();
        let r = s.split('').reverse().join('');
        let num = parseInt(s + r.substring(1));

        if (num >= n && isPrime(num)) {
            return num;
        }
    }
    return -1;

    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }
};
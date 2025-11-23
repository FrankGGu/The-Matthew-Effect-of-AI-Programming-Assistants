var sumOfLargestPrimeSubstrings = function(s) {
    let sum = 0;
    for (let i = 0; i < s.length; i++) {
        for (let j = i; j < s.length; j++) {
            const sub = s.substring(i, j + 1);
            const num = parseInt(sub);
            if (num >= 2 && num <= 1000 && isPrime(num)) {
                sum += num;
            }
        }
    }
    return sum;

    function isPrime(n) {
        if (n <= 1) return false;
        for (let i = 2; i <= Math.sqrt(n); i++) {
            if (n % i === 0) return false;
        }
        return true;
    }
};
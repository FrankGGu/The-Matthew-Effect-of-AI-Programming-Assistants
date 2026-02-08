function largestPrimeSubstring(s) {
    function isPrime(num) {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    }

    let maxPrime = -1;
    let currentNum = '';

    for (let i = 0; i < s.length; i++) {
        if (s[i] >= '0' && s[i] <= '9') {
            currentNum += s[i];
        } else {
            if (currentNum) {
                const num = parseInt(currentNum);
                if (isPrime(num)) {
                    maxPrime = Math.max(maxPrime, num);
                }
                currentNum = '';
            }
        }
    }

    if (currentNum) {
        const num = parseInt(currentNum);
        if (isPrime(num)) {
            maxPrime = Math.max(maxPrime, num);
        }
    }

    return maxPrime;
}
function sumOfLargestPrimeSubstrings(s) {
    function isPrime(num) {
        if (num <= 1) return false;
        if (num <= 3) return true;
        if (num % 2 === 0 || num % 3 === 0) return false;
        for (let i = 5; i * i <= num; i = i + 6) {
            if (num % i === 0 || num % (i + 2) === 0) return false;
        }
        return true;
    }

    let totalSum = 0;
    const MAX_DIGITS_TO_CONSIDER = 7; 

    for (let i = 0; i < s.length; i++) {
        let largestPrimeFor_i = 0;
        let currentNum = 0;

        for (let j = i; j < Math.min(s.length, i + MAX_DIGITS_TO_CONSIDER); j++) {
            if (s[i] === '0' && j > i) {
                break;
            }

            const digit = parseInt(s[j]);
            currentNum = currentNum * 10 + digit;

            if (isPrime(currentNum)) {
                largestPrimeFor_i = Math.max(largestPrimeFor_i, currentNum);
            }
        }
        totalSum += largestPrimeFor_i;
    }

    return totalSum;
}
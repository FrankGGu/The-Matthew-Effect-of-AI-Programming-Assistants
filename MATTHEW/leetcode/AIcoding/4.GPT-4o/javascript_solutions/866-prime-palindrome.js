var primePalindrome = function(N) {
    const isPrime = num => {
        if (num < 2) return false;
        for (let i = 2; i * i <= num; i++) {
            if (num % i === 0) return false;
        }
        return true;
    };

    const isPalindrome = num => {
        const str = num.toString();
        return str === str.split('').reverse().join('');
    };

    for (let i = N; ; i++) {
        if (isPalindrome(i) && isPrime(i)) {
            return i;
        }
    }
};
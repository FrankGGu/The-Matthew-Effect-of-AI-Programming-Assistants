function isPrime(num) {
    if (num < 2) return false;
    if (num === 2 || num === 3) return true;
    if (num % 2 === 0 || num % 3 === 0) return false;
    for (let i = 5; i * i <= num; i += 6) {
        if (num % i === 0 || num % (i + 2) === 0) {
            return false;
        }
    }
    return true;
}

function primePalindrome(N) {
    if (N <= 2) return 2;
    if (N <= 3) return 3;
    if (N <= 5) return 5;
    if (N <= 7) return 7;
    if (N <= 11) return 11;

    for (let i = 1; i < 100000; i++) {
        let s = String(i);
        let reversedPrefix = s.substring(0, s.length - 1).split('').reverse().join('');
        let palindrome = parseInt(s + reversedPrefix);

        if (palindrome >= N && isPrime(palindrome)) {
            return palindrome;
        }
    }
    return -1;
}
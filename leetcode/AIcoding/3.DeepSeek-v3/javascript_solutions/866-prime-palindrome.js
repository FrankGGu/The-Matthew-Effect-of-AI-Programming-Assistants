var primePalindrome = function(N) {
    if (N <= 2) return 2;
    if (N <= 3) return 3;
    if (N <= 5) return 5;
    if (N <= 7) return 7;
    if (N <= 11) return 11;

    for (let i = 10; i < 20000; i++) {
        let s = i.toString();
        let rs = s.split('').reverse().join('');
        let num = parseInt(s + rs.slice(1), 10);
        if (num >= N && isPrime(num)) {
            return num;
        }
    }

    return -1;
};

function isPrime(n) {
    if (n < 2) return false;
    if (n === 2) return true;
    if (n % 2 === 0) return false;
    for (let i = 3; i * i <= n; i += 2) {
        if (n % i === 0) return false;
    }
    return true;
}
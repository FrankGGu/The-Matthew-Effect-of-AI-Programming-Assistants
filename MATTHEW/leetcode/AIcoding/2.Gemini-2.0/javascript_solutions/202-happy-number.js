var isHappy = function(n) {
    let seen = new Set();
    while (n !== 1 && !seen.has(n)) {
        seen.add(n);
        let sum = 0;
        let num = n;
        while (num > 0) {
            let digit = num % 10;
            sum += digit * digit;
            num = Math.floor(num / 10);
        }
        n = sum;
    }
    return n === 1;
};
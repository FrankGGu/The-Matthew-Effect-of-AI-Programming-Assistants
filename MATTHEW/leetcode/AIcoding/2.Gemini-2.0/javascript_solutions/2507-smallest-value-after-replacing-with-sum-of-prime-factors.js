var smallestValue = function(n) {
    let sum = 0;
    let originalN = n;

    while (true) {
        sum = 0;
        n = originalN;
        for (let i = 2; i * i <= n; i++) {
            while (n % i === 0) {
                sum += i;
                n /= i;
            }
        }
        if (n > 1) {
            sum += n;
        }

        if (sum === originalN) {
            return sum;
        }

        originalN = sum;
    }
};
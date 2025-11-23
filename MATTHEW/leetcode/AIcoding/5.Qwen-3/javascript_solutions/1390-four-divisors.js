function sumOfDivisors(n) {
    let sum = 0;
    for (let i = 1; i <= Math.sqrt(n); i++) {
        if (n % i === 0) {
            let j = n / i;
            if (i === j) {
                sum += i;
            } else {
                sum += i + j;
            }
        }
    }
    return sum;
}

function fourDivisors(n) {
    let total = 0;
    for (let i = 1; i <= n; i++) {
        let divisors = 0;
        for (let j = 1; j <= Math.sqrt(i); j++) {
            if (i % j === 0) {
                let k = i / j;
                if (j === k) {
                    divisors++;
                } else {
                    divisors += 2;
                }
            }
        }
        if (divisors === 4) {
            total += i;
        }
    }
    return total;
}
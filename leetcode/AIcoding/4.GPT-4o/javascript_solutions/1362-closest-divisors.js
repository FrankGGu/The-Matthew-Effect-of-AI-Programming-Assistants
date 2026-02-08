var closestDivisors = function(num) {
    const findDivisors = (n) => {
        let closest = [1, n + 1];
        for (let i = 1; i <= Math.sqrt(n); i++) {
            if (n % i === 0) {
                const div1 = i;
                const div2 = n / i;
                if (Math.abs(div1 - div2) < Math.abs(closest[0] - closest[1])) {
                    closest = [div1, div2];
                }
            }
        }
        return closest;
    };

    const divisors1 = findDivisors(num + 1);
    const divisors2 = findDivisors(num + 2);

    return Math.abs(divisors1[0] - divisors1[1]) <= Math.abs(divisors2[0] - divisors2[1]) ? divisors1 : divisors2;
};
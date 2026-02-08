var closestDivisors = function(num) {
    const findDivisors = (n) => {
        let sqrtN = Math.floor(Math.sqrt(n));
        for (let i = sqrtN; i >= 1; i--) {
            if (n % i === 0) {
                return [i, n / i];
            }
        }
    };

    const pair1 = findDivisors(num + 1);
    const pair2 = findDivisors(num + 2);

    const diff1 = Math.abs(pair1[0] - pair1[1]);
    const diff2 = Math.abs(pair2[0] - pair2[1]);

    if (diff1 <= diff2) {
        return pair1;
    } else {
        return pair2;
    }
};
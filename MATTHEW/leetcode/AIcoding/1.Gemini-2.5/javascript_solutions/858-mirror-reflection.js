var mirrorReflection = function(p, q) {
    const gcd = (a, b) => {
        while (b) {
            [a, b] = [b, a % b];
        }
        return a;
    };

    const commonDivisor = gcd(p, q);

    const p_prime = p / commonDivisor;
    const q_prime = q / commonDivisor;

    if (p_prime % 2 === 0) {
        return 0;
    } else {
        if (q_prime % 2 === 1) {
            return 1;
        } else {
            return 2;
        }
    }
};
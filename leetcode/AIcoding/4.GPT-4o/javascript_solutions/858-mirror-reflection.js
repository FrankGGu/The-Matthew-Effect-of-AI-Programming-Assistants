var mirrorReflection = function(p, q) {
    let gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    let g = gcd(p, q);
    let m = p / g;
    let n = q / g;

    if (m % 2 === 0 && n % 2 === 0) return 0;
    if (m % 2 === 1 && n % 2 === 0) return 1;
    if (m % 2 === 1 && n % 2 === 1) return 2;
    return 0;
};
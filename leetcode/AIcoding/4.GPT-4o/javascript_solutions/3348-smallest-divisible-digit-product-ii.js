function smallestDivisible(num) {
    let result = 1;
    for (let i = 1; i <= num; i++) {
        result = lcm(result, i);
    }
    return result;
}

function gcd(a, b) {
    return b === 0 ? a : gcd(b, a % b);
}

function lcm(a, b) {
    return (a * b) / gcd(a, b);
}
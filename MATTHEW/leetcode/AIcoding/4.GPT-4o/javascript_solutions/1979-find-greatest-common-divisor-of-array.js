function findGCD(nums) {
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    const max = Math.max(...nums);
    const min = Math.min(...nums);
    return gcd(max, min);
}
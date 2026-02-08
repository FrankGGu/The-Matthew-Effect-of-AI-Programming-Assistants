function isGoodArray(nums) {
    const gcd = (a, b) => b === 0 ? a : gcd(b, a % b);
    return nums.reduce(gcd) === 1;
}
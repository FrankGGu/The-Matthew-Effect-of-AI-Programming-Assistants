function isDivisible(n, nums) {
    const mod = 10 ** 9 + 7;
    let result = 0;
    for (let i = 0; i < nums.length; i++) {
        result = (result * 10 + nums[i]) % mod;
        if (result % n === 0) return true;
    }
    return false;
}
var concatenatedBinary = function(nums) {
    let result = 0;
    const MOD = 10**9 + 7;
    for (let num of nums) {
        let len = Math.floor(Math.log2(num)) + 1;
        result = ((result << len) % MOD + num) % MOD;
    }
    return result;
};
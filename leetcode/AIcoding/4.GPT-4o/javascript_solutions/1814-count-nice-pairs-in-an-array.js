var countNicePairs = function(nums) {
    const MOD = 10**9 + 7;
    let count = 0;
    let map = new Map();

    for (let num of nums) {
        let rev = parseInt(num.toString().split('').reverse().join(''));
        let diff = (num - rev + MOD) % MOD;
        count = (count + (map.get(diff) || 0)) % MOD;
        map.set(diff, (map.get(diff) || 0) + 1);
    }

    return count;
};
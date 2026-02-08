var doubleModPow = function(nums, a, b, m) {
    let count = 0;
    for (const num of nums) {
        const firstMod = Math.pow(num, a) % 10;
        const secondMod = Math.pow(firstMod, b) % m;
        if (secondMod === 0) {
            count++;
        }
    }
    return count;
};
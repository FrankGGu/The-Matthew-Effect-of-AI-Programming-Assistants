var countNicePairs = function(nums) {
    const MOD = 10 ** 9 + 7;
    const diffCounts = new Map();
    let totalPairs = 0;

    function rev(n) {
        let reversedN = 0;
        let temp = n;
        while (temp > 0) {
            const digit = temp % 10;
            reversedN = reversedN * 10 + digit;
            temp = Math.floor(temp / 10);
        }
        return reversedN;
    }

    for (let i = 0; i < nums.length; i++) {
        const num = nums[i];
        const r_num = rev(num);
        const diff = num - r_num;

        const currentCountForDiff = diffCounts.get(diff) || 0;
        totalPairs = (totalPairs + currentCountForDiff) % MOD;

        diffCounts.set(diff, currentCountForDiff + 1);
    }

    return totalPairs;
};
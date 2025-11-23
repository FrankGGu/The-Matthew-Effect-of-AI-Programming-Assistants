var countNicePairs = function(nums) {
    const MOD = 1e9 + 7;
    const rev = (num) => {
        let reversed = 0;
        while (num > 0) {
            reversed = reversed * 10 + num % 10;
            num = Math.floor(num / 10);
        }
        return reversed;
    };

    const freq = {};
    let count = 0;

    for (const num of nums) {
        const diff = num - rev(num);
        if (freq[diff] !== undefined) {
            count = (count + freq[diff]) % MOD;
            freq[diff]++;
        } else {
            freq[diff] = 1;
        }
    }

    return count;
};
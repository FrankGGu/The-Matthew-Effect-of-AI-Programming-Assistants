var countNicePairs = function(nums) {
    const MOD = 10**9 + 7;
    const count = {};
    let ans = 0;

    for (const num of nums) {
        const diff = num - reverse(num);
        if (count[diff] === undefined) {
            count[diff] = 0;
        }
        ans = (ans + count[diff]) % MOD;
        count[diff]++;
    }

    return ans;

    function reverse(num) {
        let reversed = 0;
        let temp = num;
        while (temp > 0) {
            reversed = reversed * 10 + temp % 10;
            temp = Math.floor(temp / 10);
        }
        return reversed;
    }
};
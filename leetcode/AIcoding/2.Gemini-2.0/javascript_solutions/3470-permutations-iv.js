var permutationCount = function(nums) {
    const n = nums.length;
    const count = {};
    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    let memo = new Map();

    function dp(remaining) {
        let key = JSON.stringify(remaining);
        if (memo.has(key)) {
            return memo.get(key);
        }

        if (remaining.length === 0) {
            return 1;
        }

        let total = 0;
        for (const num in count) {
            if (count[num] > 0 && remaining.includes(parseInt(num))) {
                count[num]--;
                let nextRemaining = remaining.slice();
                nextRemaining.splice(nextRemaining.indexOf(parseInt(num)), 1);
                total += dp(nextRemaining);
                count[num]++;
            }
        }

        memo.set(key, total);
        return total;
    }

    return dp(nums);
};
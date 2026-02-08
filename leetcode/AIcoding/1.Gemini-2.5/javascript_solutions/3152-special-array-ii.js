var isArraySpecial = function(nums, queries) {
    const n = nums.length;
    const m = queries.length;
    const results = new Array(m);

    if (n === 1) {
        for (let i = 0; i < m; i++) {
            results[i] = true;
        }
        return results;
    }

    const badPairs = new Array(n - 1);
    for (let i = 0; i < n - 1; i++) {
        if ((nums[i] % 2) === (nums[i+1] % 2)) {
            badPairs[i] = 1;
        } else {
            badPairs[i] = 0;
        }
    }

    const prefixSumBad = new Array(n).fill(0);
    for (let i = 0; i < n - 1; i++) {
        prefixSumBad[i+1] = prefixSumBad[i] + badPairs[i];
    }

    for (let i = 0; i < m; i++) {
        const [from, to] = queries[i];

        if (from === to) {
            results[i] = true;
            continue;
        }

        const violationsInRange = prefixSumBad[to] - prefixSumBad[from];

        results[i] = (violationsInRange === 0);
    }

    return results;
};
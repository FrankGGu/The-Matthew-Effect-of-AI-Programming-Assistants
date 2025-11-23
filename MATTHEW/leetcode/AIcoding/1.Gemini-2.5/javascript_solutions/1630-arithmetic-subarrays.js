var checkArithmeticSubarrays = function(nums, queries) {
    const results = [];

    const isArithmetic = (arr) => {
        const n = arr.length;

        if (n <= 2) {
            return true;
        }

        arr.sort((a, b) => a - b);

        const diff = arr[1] - arr[0];

        for (let i = 2; i < n; i++) {
            if (arr[i] - arr[i - 1] !== diff) {
                return false;
            }
        }

        return true;
    };

    for (let i = 0; i < queries.length; i++) {
        const l = queries[i][0];
        const r = queries[i][1];

        const subarray = nums.slice(l, r + 1);
        results.push(isArithmetic(subarray));
    }

    return results;
};
var maximumOr = function(nums, k) {
    const n = nums.length;
    if (n === 0) {
        return 0;
    }

    const bigIntNums = nums.map(num => BigInt(num));

    const prefixOr = new Array(n);
    const suffixOr = new Array(n);

    prefixOr[0] = bigIntNums[0];
    for (let i = 1; i < n; i++) {
        prefixOr[i] = prefixOr[i - 1] | bigIntNums[i];
    }

    suffixOr[n - 1] = bigIntNums[n - 1];
    for (let i = n - 2; i >= 0; i--) {
        suffixOr[i] = suffixOr[i + 1] | bigIntNums[i];
    }

    let maxOverallOr = 0n;
    const multiplier = 1n << BigInt(k);

    for (let i = 0; i < n; i++) {
        let currentOrWithoutI = 0n;
        if (i > 0) {
            currentOrWithoutI |= prefixOr[i - 1];
        }
        if (i < n - 1) {
            currentOrWithoutI |= suffixOr[i + 1];
        }

        const modifiedNum = bigIntNums[i] * multiplier;
        const currentOverallOr = currentOrWithoutI | modifiedNum;
        if (currentOverallOr > maxOverallOr) {
            maxOverallOr = currentOverallOr;
        }
    }

    return Number(maxOverallOr);
};
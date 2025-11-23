var maxSubarrayWithEqualProducts = function(nums) {
    const n = nums.length;

    const prefixZeros = new Array(n + 1).fill(0);
    const prefixNegatives = new Array(n + 1).fill(0);
    const prefixLargeMagnitudes = new Array(n + 1).fill(0);

    for (let k = 0; k < n; k++) {
        prefixZeros[k + 1] = prefixZeros[k] + (nums[k] === 0 ? 1 : 0);
        prefixNegatives[k + 1] = prefixNegatives[k] + (nums[k] < 0 ? 1 : 0);
        prefixLargeMagnitudes[k + 1] = prefixLargeMagnitudes[k] + (Math.abs(nums[k]) > 1 ? 1 : 0);
    }

    const getSimplifiedProduct = (i, j) => {
        const numZeros = prefixZeros[j + 1] - prefixZeros[i];
        if (numZeros > 0) {
            return 0;
        }

        const numNegatives = prefixNegatives[j + 1] - prefixNegatives[i];
        const hasLargeMagnitude = (prefixLargeMagnitudes[j + 1] - prefixLargeMagnitudes[i]) > 0;

        let sign = (numNegatives % 2 === 0) ? 1 : -1;

        if (hasLargeMagnitude) {
            return sign * 2;
        } else {
            return sign * 1;
        }
    };

    const productIntervals = new Map();

    for (let i = 0; i < n; i++) {
        for (let j = i; j < n; j++) {
            const product = getSimplifiedProduct(i, j);
            if (!productIntervals.has(product)) {
                productIntervals.set(product, []);
            }
            productIntervals.get(product).push([i, j]);
        }
    }

    let maxTotalLen = 0;

    for (const [product, intervals] of productIntervals.entries()) {
        if (intervals.length < 2) {
            continue;
        }

        const intervalsByStart = intervals.slice().sort((a, b) => a[0] - b[0]);
        const intervalsByEnd = intervals.slice().sort((a, b) => a[1] - b[1]);

        let ptrEnd = 0;
        let maxLenOtherInterval = 0;

        for (let x = 0; x < intervalsByStart.length; x++) {
            const [i, j] = intervalsByStart[x];
            const currentLen = j - i + 1;

            while (ptrEnd < intervalsByEnd.length && intervalsByEnd[ptrEnd][1] < i) {
                const [k, l] = intervalsByEnd[ptrEnd];
                maxLenOtherInterval = Math.max(maxLenOtherInterval, l - k + 1);
                ptrEnd++;
            }

            if (maxLenOtherInterval > 0) {
                maxTotalLen = Math.max(maxTotalLen, currentLen + maxLenOtherInterval);
            }
        }
    }

    return maxTotalLen;
};
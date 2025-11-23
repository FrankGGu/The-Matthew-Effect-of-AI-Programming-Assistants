var waysToMakeFair = function(nums) {
    const n = nums.length;

    const evenPrefixSum = new Array(n + 1).fill(0);
    const oddPrefixSum = new Array(n + 1).fill(0);

    for (let i = 0; i < n; i++) {
        evenPrefixSum[i + 1] = evenPrefixSum[i];
        oddPrefixSum[i + 1] = oddPrefixSum[i];
        if (i % 2 === 0) {
            evenPrefixSum[i + 1] += nums[i];
        } else {
            oddPrefixSum[i + 1] += nums[i];
        }
    }

    const evenSuffixSum = new Array(n + 1).fill(0);
    const oddSuffixSum = new Array(n + 1).fill(0);

    for (let i = n - 1; i >= 0; i--) {
        evenSuffixSum[i] = evenSuffixSum[i + 1];
        oddSuffixSum[i] = oddSuffixSum[i + 1];
        if (i % 2 === 0) {
            evenSuffixSum[i] += nums[i];
        } else {
            oddSuffixSum[i] += nums[i];
        }
    }

    let fairCount = 0;

    for (let i = 0; i < n; i++) {
        const currentEvenSum = evenPrefixSum[i] + oddSuffixSum[i + 1];
        const currentOddSum = oddPrefixSum[i] + evenSuffixSum[i + 1];

        if (currentEvenSum === currentOddSum) {
            fairCount++;
        }
    }

    return fairCount;
};
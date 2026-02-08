var countIncreasingQuadruplets = function(nums) {
    const n = nums.length;
    if (n < 4) {
        return 0;
    }

    const unique = Array.from(new Set(nums)).sort((a, b) => a - b);
    const valToRank = new Map();
    for (let i = 0; i < unique.length; i++) {
        valToRank.set(unique[i], i);
    }
    const nRanks = unique.length;

    const leftLess = Array(n).fill(0).map(() => Array(nRanks).fill(0));
    const currentCountsByRankLeft = Array(nRanks).fill(0);
    for (let j = 0; j < n; j++) {
        let sumSoFar = 0;
        for (let r = 0; r < nRanks; r++) {
            leftLess[j][r] = sumSoFar;
            sumSoFar += currentCountsByRankLeft[r];
        }
        currentCountsByRankLeft[valToRank.get(nums[j])]++;
    }

    const rightGreater = Array(n).fill(0).map(() => Array(nRanks).fill(0));
    const currentCountsByRankRight = Array(nRanks).fill(0);
    for (let k = n - 1; k >= 0; k--) {
        let sumSoFar = 0;
        for (let r = nRanks - 1; r >= 0; r--) {
            rightGreater[k][r] = sumSoFar;
            sumSoFar += currentCountsByRankRight[r];
        }
        currentCountsByRankRight[valToRank.get(nums[k])]++;
    }

    let totalQuadruplets = 0;
    for (let j = 1; j < n - 2; j++) {
        for (let k = j + 1; k < n - 1; k++) {
            if (nums[k] < nums[j]) {
                const countI = leftLess[j][valToRank.get(nums[k])];
                const countL = rightGreater[k][valToRank.get(nums[j])];
                totalQuadruplets += countI * countL;
            }
        }
    }

    return totalQuadruplets;
};
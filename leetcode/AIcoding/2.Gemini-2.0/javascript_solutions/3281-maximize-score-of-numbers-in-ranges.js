var maximizeScore = function(nums, ranges) {
    const n = nums.length;
    const m = ranges.length;

    nums.sort((a, b) => a - b);

    let maxScore = 0;
    for (let i = 0; i < (1 << m); i++) {
        let temp = new Array(n).fill(0);
        let count = 0;

        for (let j = 0; j < m; j++) {
            if ((i >> j) & 1) {
                count++;
                let start = ranges[j][0];
                let end = ranges[j][1];
                for (let k = start; k <= end; k++) {
                    temp[k]++;
                }
            }
        }

        let arr = [];
        for (let k = 0; k < n; k++) {
            arr.push([temp[k], k]);
        }

        arr.sort((a, b) => a[0] - b[0]);

        let currentScore = 0;
        for (let k = 0; k < n; k++) {
            currentScore += arr[k][0] * nums[k];
        }

        maxScore = Math.max(maxScore, currentScore);
    }

    return maxScore;
};
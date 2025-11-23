var maxSumQueries = function(nums1, nums2, queries) {
    const n = nums1.length;
    const combined = [];
    for (let i = 0; i < n; i++) {
        combined.push([nums1[i], nums2[i]]);
    }
    combined.sort((a, b) => b[0] - a[0]);

    const maxSums = [];
    let currentMax = 0;
    const active = [];

    for (const [num1, num2] of combined) {
        if (num2 > currentMax) {
            currentMax = num2;
        }
        active.push(currentMax);
        maxSums.push(num1 + currentMax);
    }

    const results = [];
    for (const [x, y] of queries) {
        let maxSum = 0;
        for (let i = 0; i < n; i++) {
            if (combined[i][0] >= x && combined[i][1] >= y) {
                maxSum = Math.max(maxSum, maxSums[i]);
            }
        }
        results.push(maxSum);
    }

    return results;
};
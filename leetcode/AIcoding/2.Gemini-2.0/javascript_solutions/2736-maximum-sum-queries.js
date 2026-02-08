var maximumSumQueries = function(nums1, nums2, queries) {
    const n = nums1.length;
    const m = queries.length;
    const pairs = [];
    for (let i = 0; i < n; i++) {
        pairs.push([nums1[i], nums2[i]]);
    }
    pairs.sort((a, b) => b[0] - a[0]);

    const queryIndices = Array.from({ length: m }, (_, i) => i);
    queryIndices.sort((a, b) => queries[b][0] - queries[a][0]);

    const result = new Array(m);
    const stack = [];
    let j = 0;

    for (const queryIndex of queryIndices) {
        const [x, y] = queries[queryIndex];

        while (j < n && pairs[j][0] >= x) {
            const num1 = pairs[j][0];
            const num2 = pairs[j][1];
            const sum = num1 + num2;

            while (stack.length > 0 && stack[stack.length - 1][1] <= sum) {
                stack.pop();
            }

            stack.push([num2, sum]);
            j++;
        }

        let maxSum = -1;
        let left = 0;
        let right = stack.length - 1;

        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (stack[mid][0] >= y) {
                maxSum = stack[mid][1];
                right = mid - 1;
            } else {
                left = mid + 1;
            }
        }

        result[queryIndex] = maxSum;
    }

    return result;
};
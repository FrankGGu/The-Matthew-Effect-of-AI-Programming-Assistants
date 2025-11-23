var markElements = function(nums, queries) {
    const n = nums.length;
    const m = queries.length;
    const marked = new Array(n).fill(false);
    const result = new Array(m).fill(0);

    for (let i = 0; i < m; i++) {
        const type = queries[i][0];
        const index = queries[i][1];

        if (type === 0) {
            if (!marked[index]) {
                marked[index] = true;
                result[i] = 1;
            }
        } else {
            let count = 0;
            for (let j = 0; j < n; j++) {
                if (nums[j] <= index && !marked[j]) {
                    marked[j] = true;
                    count++;
                }
            }
            result[i] = count;
        }
    }

    return result;
};
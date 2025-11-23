var answerQueries = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const n = nums.length;
    const m = queries.length;
    const result = new Array(m);

    for (let i = 0; i < m; i++) {
        let sum = 0;
        let count = 0;
        for (let j = 0; j < n; j++) {
            if (sum + nums[j] <= queries[i]) {
                sum += nums[j];
                count++;
            } else {
                break;
            }
        }
        result[i] = count;
    }

    return result;
};
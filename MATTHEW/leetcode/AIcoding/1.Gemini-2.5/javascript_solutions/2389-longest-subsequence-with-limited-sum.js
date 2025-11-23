var answerQueries = function(nums, queries) {
    nums.sort((a, b) => a - b);

    const prefixSums = new Array(nums.length);
    if (nums.length > 0) {
        prefixSums[0] = nums[0];
        for (let i = 1; i < nums.length; i++) {
            prefixSums[i] = prefixSums[i - 1] + nums[i];
        }
    }

    const results = [];

    for (const q of queries) {
        let low = 0;
        let high = nums.length - 1;
        let ansIndex = -1; 

        while (low <= high) {
            let mid = Math.floor((low + high) / 2);
            if (prefixSums[mid] <= q) {
                ansIndex = mid;
                low = mid + 1;
            } else {
                high = mid - 1;
            }
        }
        results.push(ansIndex + 1);
    }

    return results;
};
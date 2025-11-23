var answerQueries = function(nums, queries) {
    nums.sort((a, b) => a - b);
    const prefixSum = [0];
    for (let num of nums) {
        prefixSum.push(prefixSum[prefixSum.length - 1] + num);
    }

    const answer = [];
    for (let query of queries) {
        let left = 0, right = prefixSum.length - 1;
        while (left <= right) {
            const mid = Math.floor((left + right) / 2);
            if (prefixSum[mid] <= query) {
                left = mid + 1;
            } else {
                right = mid - 1;
            }
        }
        answer.push(left - 1);
    }
    return answer;
};
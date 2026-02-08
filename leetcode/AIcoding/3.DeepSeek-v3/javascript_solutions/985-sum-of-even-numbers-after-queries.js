var sumEvenAfterQueries = function(nums, queries) {
    let sum = nums.reduce((acc, num) => acc + (num % 2 === 0 ? num : 0), 0);
    let result = [];

    for (let [val, index] of queries) {
        let original = nums[index];
        nums[index] += val;

        if (original % 2 === 0) {
            sum -= original;
        }
        if (nums[index] % 2 === 0) {
            sum += nums[index];
        }

        result.push(sum);
    }

    return result;
};
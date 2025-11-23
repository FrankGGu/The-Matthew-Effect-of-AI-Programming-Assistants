var sumEvenAfterQueries = function(nums, queries) {
    let sum = 0;
    for (let num of nums) {
        if (num % 2 === 0) {
            sum += num;
        }
    }

    const result = [];
    for (let query of queries) {
        const val = query[0];
        const index = query[1];

        if (nums[index] % 2 === 0) {
            sum -= nums[index];
        }

        nums[index] += val;

        if (nums[index] % 2 === 0) {
            sum += nums[index];
        }

        result.push(sum);
    }

    return result;
};
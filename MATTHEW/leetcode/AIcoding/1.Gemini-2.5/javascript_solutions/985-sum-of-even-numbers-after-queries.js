var sumEvenAfterQueries = function(nums, queries) {
    let currentEvenSum = 0;
    for (let i = 0; i < nums.length; i++) {
        if (nums[i] % 2 === 0) {
            currentEvenSum += nums[i];
        }
    }

    const results = [];

    for (let i = 0; i < queries.length; i++) {
        const val = queries[i][0];
        const index = queries[i][1];

        // If the number at nums[index] was even, subtract it from currentEvenSum
        if (nums[index] % 2 === 0) {
            currentEvenSum -= nums[index];
        }

        // Update nums[index]
        nums[index] += val;

        // If the new number at nums[index] is even, add it to currentEvenSum
        if (nums[index] % 2 === 0) {
            currentEvenSum += nums[index];
        }

        results.push(currentEvenSum);
    }

    return results;
};
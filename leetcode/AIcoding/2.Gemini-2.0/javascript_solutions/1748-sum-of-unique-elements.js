var sumOfUnique = function(nums) {
    const counts = {};
    let sum = 0;

    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    for (const num of nums) {
        if (counts[num] === 1) {
            sum += num;
        }
    }

    return sum;
};
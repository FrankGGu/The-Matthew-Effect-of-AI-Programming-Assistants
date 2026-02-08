var sumOfUnique = function(nums) {
    const count = {};
    let sum = 0;

    for (const num of nums) {
        count[num] = (count[num] || 0) + 1;
    }

    for (const num in count) {
        if (count[num] === 1) {
            sum += Number(num);
        }
    }

    return sum;
};
var sumOfUnique = function(nums) {
    const counts = {};
    for (const num of nums) {
        counts[num] = (counts[num] || 0) + 1;
    }

    let sum = 0;
    for (const numStr in counts) {
        if (counts[numStr] === 1) {
            sum += parseInt(numStr);
        }
    }

    return sum;
};
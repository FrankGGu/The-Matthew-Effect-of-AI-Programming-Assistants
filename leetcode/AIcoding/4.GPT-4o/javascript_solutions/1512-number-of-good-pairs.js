var numIdenticalPairs = function(nums) {
    let count = 0;
    const frequency = {};
    for (const num of nums) {
        if (frequency[num]) {
            count += frequency[num];
            frequency[num]++;
        } else {
            frequency[num] = 1;
        }
    }
    return count;
};
var numIdenticalPairs = function(nums) {
    let count = 0;
    const freq = {};
    for (let num of nums) {
        if (freq[num]) {
            count += freq[num];
            freq[num]++;
        } else {
            freq[num] = 1;
        }
    }
    return count;
};
var countGoodPairs = function(nums) {
    const count = new Map();
    let goodPairs = 0;

    for (const num of nums) {
        if (count.has(num)) {
            goodPairs += count.get(num);
            count.set(num, count.get(num) + 1);
        } else {
            count.set(num, 1);
        }
    }

    return goodPairs;
};
var numberOfPairs = function(nums) {
    const freq = {};
    let pairs = 0;
    let leftover = 0;

    for (const num of nums) {
        if (freq[num]) {
            freq[num]++;
        } else {
            freq[num] = 1;
        }
    }

    for (const key in freq) {
        pairs += Math.floor(freq[key] / 2);
        leftover += freq[key] % 2;
    }

    return [pairs, leftover];
};
var findLonely = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }

    const lonelyNumbers = [];
    for (const num of nums) {
        if (freq[num] === 1 && !(num - 1 in freq) && !(num + 1 in freq)) {
            lonelyNumbers.push(num);
        }
    }

    return lonelyNumbers;
};
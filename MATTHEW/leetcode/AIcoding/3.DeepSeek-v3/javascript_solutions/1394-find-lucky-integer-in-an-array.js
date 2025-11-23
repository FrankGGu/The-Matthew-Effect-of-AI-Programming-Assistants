var findLucky = function(arr) {
    const frequency = {};
    for (const num of arr) {
        frequency[num] = (frequency[num] || 0) + 1;
    }
    let maxLucky = -1;
    for (const num in frequency) {
        if (parseInt(num) === frequency[num]) {
            maxLucky = Math.max(maxLucky, frequency[num]);
        }
    }
    return maxLucky;
};
var sumOfUnique = function(nums) {
    const freq = {};
    for (const num of nums) {
        freq[num] = (freq[num] || 0) + 1;
    }
    let sum = 0;
    for (const num in freq) {
        if (freq[num] === 1) {
            sum += parseInt(num);
        }
    }
    return sum;
};
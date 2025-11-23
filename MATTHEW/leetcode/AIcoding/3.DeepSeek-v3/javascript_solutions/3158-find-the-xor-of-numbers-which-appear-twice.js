var duplicateNumbersXOR = function(nums) {
    const seen = new Set();
    let xor = 0;
    for (const num of nums) {
        if (seen.has(num)) {
            xor ^= num;
        } else {
            seen.add(num);
        }
    }
    return xor;
};
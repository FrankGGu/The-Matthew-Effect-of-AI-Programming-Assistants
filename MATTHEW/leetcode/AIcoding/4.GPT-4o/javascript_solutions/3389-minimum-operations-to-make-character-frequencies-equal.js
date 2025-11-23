var minOperations = function(s) {
    const freq = {};
    for (const char of s) {
        freq[char] = (freq[char] || 0) + 1;
    }
    const counts = Object.values(freq);
    const maxFreq = Math.max(...counts);
    let operations = 0;

    for (const count of counts) {
        operations += count === maxFreq ? 0 : count;
    }

    return operations;
};
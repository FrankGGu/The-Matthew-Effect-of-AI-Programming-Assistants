var minOperations = function(s) {
    const count = {};
    for (const char of s) {
        count[char] = (count[char] || 0) + 1;
    }
    const frequencies = Object.values(count);
    let operations = 0;
    const seen = new Set();
    for (const freq of frequencies) {
        let current = freq;
        while (seen.has(current)) {
            current--;
            operations++;
        }
        if (current > 0) {
            seen.add(current);
        }
    }
    return operations;
};
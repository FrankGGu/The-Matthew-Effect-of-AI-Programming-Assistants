var maxOperations = function(nums, k) {
    let operations = 0;
    const freqMap = new Map();

    for (const num of nums) {
        const complement = k - num;
        if (freqMap.has(complement) && freqMap.get(complement) > 0) {
            operations++;
            freqMap.set(complement, freqMap.get(complement) - 1);
        } else {
            freqMap.set(num, (freqMap.get(num) || 0) + 1);
        }
    }

    return operations;
};
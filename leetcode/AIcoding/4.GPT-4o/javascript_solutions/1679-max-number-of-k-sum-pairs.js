var maxOperations = function(nums, k) {
    let count = 0;
    const freqMap = new Map();

    for (const num of nums) {
        const complement = k - num;
        if (freqMap.get(complement) > 0) {
            count++;
            freqMap.set(complement, freqMap.get(complement) - 1);
        } else {
            freqMap.set(num, (freqMap.get(num) || 0) + 1);
        }
    }

    return count;
};
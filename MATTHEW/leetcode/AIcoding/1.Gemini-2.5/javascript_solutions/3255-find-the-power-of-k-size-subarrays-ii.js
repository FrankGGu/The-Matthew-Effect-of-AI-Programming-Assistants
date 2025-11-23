var findThePowerOfKSizeSubarraysII = function(nums, k) {
    const n = nums.length;
    const result = [];
    if (k === 0 || n === 0 || k > n) {
        return result;
    }

    const freqMap = new Map();
    let currentPower = 0;
    let left = 0;

    for (let right = 0; right < n; right++) {
        const numR = nums[right];

        const oldFreqR = freqMap.get(numR) || 0;
        currentPower -= numR * oldFreqR;
        freqMap.set(numR, oldFreqR + 1);
        currentPower += numR * (oldFreqR + 1);

        if (right - left + 1 === k) {
            result.push(currentPower);

            const numL = nums[left];
            const oldFreqL = freqMap.get(numL);
            currentPower -= numL * oldFreqL;
            freqMap.set(numL, oldFreqL - 1);
            currentPower += numL * (oldFreqL - 1);

            if (freqMap.get(numL) === 0) {
                freqMap.delete(numL);
            }
            left++;
        }
    }

    return result;
};
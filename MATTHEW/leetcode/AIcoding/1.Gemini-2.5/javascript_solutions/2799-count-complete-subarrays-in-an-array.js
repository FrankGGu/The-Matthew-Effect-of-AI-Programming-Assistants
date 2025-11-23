var countCompleteSubarrays = function(nums) {
    const distinctElementsInNums = new Set(nums);
    const k = distinctElementsInNums.size;

    const countSubarraysWithAtMostKDistinct = (arr, maxDistinct) => {
        let count = 0;
        let left = 0;
        const freqMap = new Map();
        let currentDistinctCount = 0;

        for (let right = 0; right < arr.length; right++) {
            const num = arr[right];
            freqMap.set(num, (freqMap.get(num) || 0) + 1);
            if (freqMap.get(num) === 1) {
                currentDistinctCount++;
            }

            while (currentDistinctCount > maxDistinct) {
                const leftNum = arr[left];
                freqMap.set(leftNum, freqMap.get(leftNum) - 1);
                if (freqMap.get(leftNum) === 0) {
                    currentDistinctCount--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    };

    return countSubarraysWithAtMostKDistinct(nums, k) - countSubarraysWithAtMostKDistinct(nums, k - 1);
};
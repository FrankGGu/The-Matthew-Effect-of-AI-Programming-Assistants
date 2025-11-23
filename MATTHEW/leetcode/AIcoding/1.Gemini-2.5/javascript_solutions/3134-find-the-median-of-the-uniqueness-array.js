var findTheMedianOfUniquenessArray = function(nums) {
    const n = nums.length;
    const totalSubarrays = n * (n + 1) / 2;
    const targetCount = Math.ceil(totalSubarrays / 2);

    const check = (x) => {
        let count = 0;
        let left = 0;
        const freqMap = new Map();
        let currentUnique = 0;

        for (let right = 0; right < n; right++) {
            const num = nums[right];
            freqMap.set(num, (freqMap.get(num) || 0) + 1);
            if (freqMap.get(num) === 1) {
                currentUnique++;
            }

            while (currentUnique > x) {
                const leftNum = nums[left];
                freqMap.set(leftNum, freqMap.get(leftNum) - 1);
                if (freqMap.get(leftNum) === 0) {
                    currentUnique--;
                }
                left++;
            }
            count += (right - left + 1);
        }
        return count;
    };

    let low = 1;
    let high = n;
    let ans = n;

    while (low <= high) {
        const mid = Math.floor((low + high) / 2);
        if (check(mid) >= targetCount) {
            ans = mid;
            high = mid - 1;
        } else {
            low = mid + 1;
        }
    }

    return ans;
};
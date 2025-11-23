var longestUnequalAdjacency = function(nums) {
    const n = nums.length;
    let maxLength = 0;

    for (let i = 0; i < n; i++) {
        let currentLength = 1;
        let lastNum = nums[i];

        for (let j = i + 1; j < n; j++) {
            if (nums[j] !== lastNum) {
                currentLength++;
                lastNum = nums[j];
            }
        }

        maxLength = Math.max(maxLength, currentLength);
    }

    return maxLength;
};
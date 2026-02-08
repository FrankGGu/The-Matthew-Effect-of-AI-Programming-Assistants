var longestAlternatingSubarray = function(nums) {
    let maxLength = 0;
    const n = nums.length;

    for (let i = 0; i < n; i++) {
        if (nums[i] % 2 === 0) { // Check if the current element is even
            let currentLength = 1;
            for (let j = i + 1; j < n; j++) {
                // Check if the parity alternates
                if ((nums[j] % 2) !== (nums[j - 1] % 2)) {
                    currentLength++;
                } else {
                    break; // Alternating sequence broken
                }
            }
            maxLength = Math.max(maxLength, currentLength);
        }
    }

    return maxLength;
};